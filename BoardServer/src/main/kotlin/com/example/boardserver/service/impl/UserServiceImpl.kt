package com.example.boardserver.service.impl

import board.UserOuterClass
import board.UserOuterClass.*
import board.UserOuterClass.User
import brave.Tracer
import com.example.boardserver.entity.*
import com.example.boardserver.exceptions.Errors
import com.example.boardserver.interceptor.ContextKeys
import com.example.boardserver.repository.CommentRepository
import com.example.boardserver.repository.TokenRepository
import com.example.boardserver.repository.UserRepository
import com.example.boardserver.service.CacheService
import com.example.boardserver.service.UserService
import com.example.boardserver.service.VerifyService
import com.example.boardserver.utils.FcmProvider
import com.example.boardserver.utils.JwtProvider
import com.example.boardserver.utils.runWithTracing
import io.grpc.Context
import io.grpc.Status
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.util.*


@Service
class UserServiceImpl(
    private val userRepository: UserRepository,
    private val commentRepository: CommentRepository,
    private val tokenRepository: TokenRepository,
    private val jwtProvider: JwtProvider,
    private val fcmProvider: FcmProvider,
    private val cacheService: CacheService,
    private val verifyService: VerifyService,
    private val tracer: Tracer
) : UserService {

    @Transactional
    override suspend fun startSignUp(userDto: User): UUID =
        runWithTracing(tracer, GetSignUp) {
            if (userRepository.existsByPhone(userDto.phone)) throw Errors.RepeatedPhoneNumber()
            if (userRepository.existsByUsername(userDto.username)) throw Errors.RepeatedUsername()
            val user = userDto.fromUserGrpc(true)
            user.password = user.password.hashPassword()
            val response = verifyService.makeCall(user.phone)
            if (response != null && user.id != null) {
                cacheService.saveUser(user.id, user)
                cacheService.saveCode(user.id, response.data.pincode)
            }
            user.id!!
        }

    @Transactional
    override suspend fun endSignUp(id: UUID, code: String): Boolean {
        val cachedCode = cacheService.getCode(id)
        if (cachedCode != code || cachedCode == "expired") throw Errors.VerifyFailed()
        val cachedUser = cacheService.getUser(id)
        userRepository.save(cachedUser)
        return true
    }

    @Transactional
    override suspend fun getLogin(request: LoginRequest): LoginResponse =
        runWithTracing(tracer, GetLogin) {
            val user = userRepository.findByUsernameWithComments(request.username).orElseThrow()
            if (!request.password.checkPassword(user.password)) throw Status.INVALID_ARGUMENT.withDescription("Неправильный пароль")
                .asException()
            val response = LoginResponse.newBuilder().setUser(user.toUserGrpc())
                .setAccessToken(jwtProvider.createUserJwt(user.id!!)).build()
            tokenRepository.deleteByUserId(user.id)
            val token = fcmProvider.createTokenEntity(user, request.deviceToken)
            user.addDeviceToken(token)
            userRepository.save(user)
            response.also { log.info("login: $it") }
        }

    @Transactional
    override suspend fun getUserAndRefresh(): UserAvatarToken =
        runWithTracing(tracer, GetUserAndRefresh) {
            val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
            var token = ContextKeys.TOKEN_KEY.get(Context.current())
            val user = userRepository.findById(userId).orElseThrow()
            if (jwtProvider.needToRefresh(token)) {
                token = jwtProvider.createUserJwt(userId)
            }
            user.isOnline = true
            userRepository.save(user)
            val response = UserAvatarToken.newBuilder().setUser(user.toUserGrpc()).setToken(token).build()
            response.also { log.info(it.toString()) }
        }

    @Transactional
    override suspend fun setOffline(online:Boolean): Boolean =
        runWithTracing(tracer, SetOffline) {
            val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
            val user = userRepository.findById(userId).orElseThrow()
            user.isOnline = false
            userRepository.save(user)
            true
        }

    override suspend fun getUserById(id: UUID): User =
        runWithTracing(tracer, GetUserById) {
            val user = userRepository.findById(id).orElseThrow()
            user.toAnotherUser()
        }

    @Transactional
    override suspend fun logOut(): Boolean =
        runWithTracing(tracer, LogOut) {
            val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
            tokenRepository.deleteByUserId(userId)
            true
        }

    @Transactional
    override suspend fun changeUserData(userDto: User): Boolean =
        runWithTracing(tracer, ChangeUserData) {
            val user = userRepository.findById(userDto.id.uuid()).orElseThrow()
            user.name = userDto.name
            user.phone = userDto.phone
            user.address = userDto.address
            user.email = userDto.email
            user.notify = userDto.notify
            userRepository.save(user)
            true
        }

    @Transactional
    override suspend fun setAvatar(image: ImageProto): Boolean =
        runWithTracing(tracer, SetAvatar) {
            val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
            val user = userRepository.findUserWithAvatar(userId).orElseThrow()
            user.addAvatar(image.fromAvatarGrpc(user))
            userRepository.save(user)
            true
        }

    @Transactional
    override suspend fun deleteUser(): Boolean =
        runWithTracing(tracer, DeleteUser) {
            val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
            userRepository.deleteById(userId)
            true
        }

    @Transactional
    override suspend fun addComment(commentDto: UserOuterClass.Comment): Boolean =
        runWithTracing(tracer, AddComment) {
            val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
            if (userId != commentDto.owner.id.uuid()) throw Errors.YouNotOwner()
            val convicted = userRepository.findById(commentDto.convicted.id.uuid()).orElseThrow()
            val creator = userRepository.findById(commentDto.owner.id.uuid()).orElseThrow()
            val comment = commentDto.fromCommentGrpc(convicted, creator)
            convicted.addComment(comment)
            userRepository.save(convicted)
            true
        }

    @Transactional
    override suspend fun deleteComment(id: UUID): Boolean =
        runWithTracing(tracer, DeleteComment) {
            commentRepository.deleteById(id)
            true
        }

    override suspend fun getComments(id: UUID): CommentsResponse =
        runWithTracing(tracer, GetComments) {
            val comments = commentRepository.findByConvictedId(id)
            comments.toRepeatedCommentGrpc().also { log.info("get comments: $it") }
        }

    override suspend fun getUserComments(): CommentsResponse =
        runWithTracing(tracer, GetUserComments) {
            val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
            val comments = commentRepository.findByCreatorId(userId)
            comments.toRepeatedCommentGrpc().also { log.info("get user comments: $it") }
        }

    companion object {
        private val log = LoggerFactory.getLogger(UserServiceImpl::class.java)

        private const val userService = "UserAPI"
        private const val GetSignUp = "$userService.getSignUp"
        private const val GetLogin = "$userService.getLogin"
        private const val GetUserAndRefresh = "$userService.getGetUserAndRefresh"
        private const val GetUserById = "$userService.getUserById"
        private const val LogOut = "$userService.logOut"
        private const val ChangeUserData = "$userService.changeUserData"
        private const val DeleteUser = "$userService.deleteUser"
        private const val AddComment = "$userService.addComment"
        private const val EditComment = "$userService.editComment"
        private const val DeleteComment = "$userService.deleteComment"
        private const val GetComments = "$userService.getComment"
        private const val GetUserComments = "$userService.getUserComment"
        private const val SetAvatar = "$userService.setAvatar"
        private const val SetOffline = "$userService.setOffline"
    }
}