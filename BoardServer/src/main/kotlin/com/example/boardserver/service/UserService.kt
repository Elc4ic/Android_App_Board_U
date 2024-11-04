package com.example.boardserver.service

import board.UserOuterClass
import board.UserOuterClass.*
import board.UserOuterClass.User
import brave.Tracer
import com.example.boardserver.entity.*
import com.example.boardserver.exceptions.NotFoundException
import com.example.boardserver.exceptions.YouNotOwnerException
import com.example.boardserver.interceptor.ContextKeys
import com.example.boardserver.interceptor.LogGrpcInterceptor
import com.example.boardserver.repository.CommentRepository
import com.example.boardserver.repository.TokenRepository
import com.example.boardserver.repository.UserRepository
import com.example.boardserver.utils.FcmProvider
import com.example.boardserver.utils.JwtProvider
import com.example.boardserver.utils.runWithTracing
import io.grpc.Context
import io.grpc.Status
import kotlinx.coroutines.withTimeout
import net.devh.boot.grpc.server.service.GrpcService
import org.slf4j.LoggerFactory
import org.springframework.transaction.annotation.Transactional


@GrpcService(interceptors = [LogGrpcInterceptor::class])
class UserService(
    private val userRepository: UserRepository,
    private val commentRepository: CommentRepository,
    private val tokenRepository: TokenRepository,
    private val jwtProvider: JwtProvider,
    private val fcmProvider: FcmProvider,
    private val tracer: Tracer
) : board.UserAPIGrpcKt.UserAPICoroutineImplBase() {

    @Transactional
    override suspend fun getSignUp(request: SignupRequest): IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, GetSignUp) {
                if (userRepository.countByPhone(request.phone) != 0) throw Status.INVALID_ARGUMENT
                    .withDescription("Аккаунт с таким номером уже существует").asException()
                if (userRepository.countByUsername(request.username) != 0) throw Status.INVALID_ARGUMENT
                    .withDescription("Пользователь с таким именем уже существует").asException()
                val newUser = User.newBuilder()
                    .setName(request.username)
                    .setUsername(request.username)
                    .setPassword(request.password.hashPassword())
                    .setPhone(request.phone).build()
                val user = newUser.fromUserGrpc()
                userRepository.save(user)
                successGrpc()
            }
        }

    @Transactional
    override suspend fun getLogin(request: LoginRequest): LoginResponse =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, GetLogin) {
                val user = userRepository.findByUsername(request.username).orElseThrow()
                if (!request.password.checkPassword(user.password)) throw Status.INVALID_ARGUMENT.withDescription("Неправильный пароль")
                    .asException()
                val response = LoginResponse.newBuilder().setUser(user.toUserGrpc())
                    .setAccessToken(jwtProvider.createUserJwt(user.id!!)).build()
                tokenRepository.deleteByUserId(user.id)
                val token = fcmProvider.createTokenEntity(user, request.deviceToken)
                user.addDeviceToken(token)
                userRepository.save(user)
                response
            }
        }


    @Transactional
    override suspend fun getUserAndRefresh(request: Empty): UserAvatarToken =
        withTimeout(timeOutMillis) {
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
                response
            }
        }

    @Transactional
    override suspend fun setOffline(request: Empty): IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, SetOffline) {
                val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
                val user = userRepository.findById(userId).orElseThrow()
                user.isOnline = false
                userRepository.save(user)
                successGrpc()
            }
        }

    @Transactional
    override suspend fun getUserById(request: UserId): User =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, GetUserById) {
                val user = userRepository.findById(request.id.uuid()).orElseThrow()
                user.toAnotherUser()
            }
        }

    @Transactional
    override suspend fun logOut(request: UserId): IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, LogOut) {
                val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
                tokenRepository.deleteByUserId(userId)
                successGrpc()
            }
        }

    @Transactional
    override suspend fun changeUserData(request: User): IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, ChangeUserData) {
                val user = userRepository.findById(request.id.uuid()).orElseThrow()
                user.name = request.name
                user.phone = request.phone
                user.address = request.address
                user.email = request.email
                user.notify = request.notify
                userRepository.save(user)
                successGrpc()
            }
        }

    @Transactional
    override suspend fun setAvatar(request: ImageProto): IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, SetAvatar) {
                val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
                val user = userRepository.findById(userId).orElseThrow()
                user.addAvatar(request.toUserAvatar(user))
                userRepository.save(user)
                successGrpc()
            }
        }

    @Transactional
    override suspend fun deleteUser(request: Empty): IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, DeleteUser) {
                val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
                userRepository.deleteById(userId)
                successGrpc()
            }
        }

    @Transactional
    override suspend fun addComment(request: UserOuterClass.Comment): IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, AddComment) {
                val convicted = userRepository.findById(request.convicted.id.uuid()).orElseThrow()
                val creator = userRepository.findById(request.owner.id.uuid()).orElseThrow()
                val comment = request.fromCommentGrpc(convicted, creator)
                convicted.addComment(comment)
                userRepository.save(convicted)
                successGrpc()
            }
        }

    @Transactional
    override suspend fun editComment(request: UserOuterClass.Comment): IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, EditComment) {
                val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
                if (userId != request.owner.id.uuid()) throw YouNotOwnerException()
                val comment = commentRepository.findById(request.id.uuid())
                    .orElseThrow { NotFoundException("Комментарий") }
                comment.rating = request.rating
                comment.text = request.text
                commentRepository.save(comment)
                successGrpc()
            }
        }

    @Transactional
    override suspend fun deleteComment(request: Id): IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, DeleteComment) {
                commentRepository.deleteById(request.id.uuid())
                successGrpc()
            }
        }


    @Transactional
    override suspend fun getComments(request: UserId): CommentsResponse =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, GetComments) {
                val comments = commentRepository.findByConvictedId(request.id.uuid())
                comments.toRepeatedCommentGrpc()
            }
        }


    @Transactional
    override suspend fun getUserComments(request: Empty): CommentsResponse =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, GetUserComments) {
                val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
                val comments = commentRepository.findByCreatorId(userId)
                comments.toRepeatedCommentGrpc()
            }
        }

    companion object {
        private val log = LoggerFactory.getLogger(UserService::class.java)
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