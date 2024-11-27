package com.example.boardserver.service.impl

import board.UserOuterClass
import board.UserOuterClass.*
import board.UserOuterClass.User
import brave.Tracer
import com.example.boardserver.entity.*
import com.example.boardserver.exceptions.GrpcErrors
import com.example.boardserver.interceptor.ContextKeys
import com.example.boardserver.repository.CommentRepository
import com.example.boardserver.repository.TokenRepository
import com.example.boardserver.repository.UserRepository
import com.example.boardserver.service.CacheService
import com.example.boardserver.service.UserService
import com.example.boardserver.utils.FcmProvider
import com.example.boardserver.utils.JwtProvider
import com.example.boardserver.utils.runWithTracing
import io.grpc.Context
import io.grpc.Status
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service
import java.util.*


@Service
class UserServiceImpl(
    private val userRepository: UserRepository,
    private val commentRepository: CommentRepository,
    private val tokenRepository: TokenRepository,
    private val jwtProvider: JwtProvider,
    private val fcmProvider: FcmProvider,
    private val cacheService: CacheService,
    private val tracer: Tracer
) : UserService {

    override suspend fun startSignUp(request: SignupRequest): User =
        runWithTracing(tracer, GetSignUp) {
            if (userRepository.existsByPhone(request.phone)) throw GrpcErrors.RepeatedPhoneNumber()
            if (userRepository.existsByUsername(request.username)) throw GrpcErrors.RepeatedUsername()
            val newUser = User.newBuilder()
                .setName(request.username)
                .setUsername(request.username)
                .setPassword(request.password.hashPassword())
                .setPhone(request.phone).build()
            val user = newUser.fromUserGrpc(true)
            cacheService.saveUser(user.id!!, user)
            newUser
        }


    override suspend fun endSignUp(request: UserId): IsSuccess {
        val user = cacheService.getUser(UUID.fromString(request.id))
        userRepository.save(user)
        return successGrpc()
    }

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


    override suspend fun getUserAndRefresh(request: Empty): UserAvatarToken =
        runWithTracing(tracer, GetUserAndRefresh) {
            val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
            var token = ContextKeys.TOKEN_KEY.get(Context.current())
            val user = userRepository.findByIdWithComments(userId).orElseThrow()
            if (jwtProvider.needToRefresh(token)) {
                token = jwtProvider.createUserJwt(userId)
            }
            user.isOnline = true
            userRepository.save(user)
            val response = UserAvatarToken.newBuilder().setUser(user.toUserGrpc()).setToken(token).build()
            response.also { log.info(it.toString()) }
        }


    override suspend fun setOffline(request: Empty): IsSuccess =
        runWithTracing(tracer, SetOffline) {
            val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
            val user = userRepository.findById(userId).orElseThrow()
            user.isOnline = false
            userRepository.save(user)
            successGrpc()
        }


    override suspend fun getUserById(request: UserId): User =
        runWithTracing(tracer, GetUserById) {
            val user = userRepository.findById(request.id.uuid()).orElseThrow()
            user.toAnotherUser().also { log.info("get user: $it") }
        }


    override suspend fun logOut(request: Empty): IsSuccess =
        runWithTracing(tracer, LogOut) {
            val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
            tokenRepository.deleteByUserId(userId)
            successGrpc()
        }


    override suspend fun changeUserData(request: User): IsSuccess =
        runWithTracing(tracer, ChangeUserData) {
            val user = userRepository.findById(request.id.uuid()).orElseThrow()
            user.name = request.name
            user.phone = request.phone
            user.address = request.address
            user.email = request.email
            user.notify = request.notify
            userRepository.save(user)
            successGrpc().also { log.info(user.toString()) }
        }


    override suspend fun setAvatar(request: ImageProto): IsSuccess =
        runWithTracing(tracer, SetAvatar) {
            val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
            val user = userRepository.findUserWithAvatar(userId).orElseThrow()
            user.addAvatar(request.fromAvatarGrpc(user))
            userRepository.save(user)
            successGrpc()
        }


    override suspend fun deleteUser(request: Empty): IsSuccess =
        runWithTracing(tracer, DeleteUser) {
            val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
            userRepository.deleteById(userId)
            successGrpc()
        }


    override suspend fun addComment(request: UserOuterClass.Comment): IsSuccess =
        runWithTracing(tracer, AddComment) {
            log.info("add comment: ${request.convicted.id} ${request.owner.id}")
            val convicted = userRepository.findUserWithComments(request.convicted.id.uuid()).orElseThrow()
            val creator = userRepository.findById(request.owner.id.uuid()).orElseThrow()
            val comment = request.fromCommentGrpc(convicted, creator)
            convicted.addComment(comment)
            userRepository.save(convicted)
            successGrpc()
        }


    override suspend fun editComment(request: UserOuterClass.Comment): IsSuccess =
        runWithTracing(tracer, EditComment) {
            val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
            if (userId != request.owner.id.uuid()) throw GrpcErrors.YouNotOwner()
            val comment = commentRepository.findById(request.id.uuid())
                .orElseThrow { GrpcErrors.NotFoundComment() }
            comment.rating = request.rating
            comment.text = request.text
            commentRepository.save(comment)
            successGrpc()
        }


    override suspend fun deleteComment(request: Id): IsSuccess =
        runWithTracing(tracer, DeleteComment) {
            commentRepository.deleteById(request.id.uuid())
            successGrpc()
        }


    override suspend fun getComments(request: UserId): CommentsResponse =
        runWithTracing(tracer, GetComments) {
            val comments = commentRepository.findByConvictedId(request.id.uuid())
            comments.toRepeatedCommentGrpc().also { log.info("get comments: $it") }
        }


    override suspend fun getUserComments(request: Empty): CommentsResponse =
        runWithTracing(tracer, GetUserComments) {
            val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
            val comments = commentRepository.findByCreatorId(userId)
            comments.toRepeatedCommentGrpc().also { log.info("get user comments: $it") }
        }


    companion object {
        private val log = LoggerFactory.getLogger(UserServiceImpl::class.java)
        private const val timeOutMillis = 5000L

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