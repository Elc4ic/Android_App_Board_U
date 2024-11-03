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
            val span = tracer.startScopedSpan(GetSignUp)
            runWithTracing(span) {
                if (userRepository.countByPhone(request.phone) == 0) {
                    if (userRepository.countByUsername(request.username) == 0) {
                        val newUser = User.newBuilder().setName(request.username).setUsername(request.username)
                            .setPassword(request.password.hashPassword()).setPhone(request.phone).build()
                        val user = newUser.fromUserGrpc()
                        userRepository.save(user)
                        successGrpc().also { it ->
                            log.info("sign up: $it").also { span.tag("response", it.toString()) }
                        }
                    } else {
                        throw Status.INVALID_ARGUMENT.withDescription("Пользователь с таким именем уже существует")
                            .asException()
                    }
                } else {
                    throw Status.INVALID_ARGUMENT.withDescription("Аккаунт с таким номером уже существует")
                        .asException()
                }
            }
        }


    override suspend fun getLogin(request: LoginRequest): LoginResponse =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(GetLogin)
            runWithTracing(span) {
                val user = userRepository.findByUsername(request.username).orElseThrow()
                if (request.password.checkPassword(user.password)) {
                    val response = LoginResponse.newBuilder().setUser(user.toUserGrpc())
                        .setAccessToken(jwtProvider.createJwt(user.id!!)).build()
                    tokenRepository.deleteByUserId(user.id)
                    tokenRepository.save(fcmProvider.createTokenEntity(user, request.deviceToken))
                    response.also { it ->
                        log.info("sign up: $it").also { span.tag("response", it.toString()) }
                    }
                } else {
                    throw Status.INVALID_ARGUMENT.withDescription("Неправильный пароль").asException()
                }
            }
        }


    override suspend fun getUserAndRefresh(request: Empty): UserAvatarToken =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(GetUserAndRefresh)
            runWithTracing(span) {
                val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
                var token = ContextKeys.TOKEN_KEY.get(Context.current())
                val user = userRepository.findById(userId).orElseThrow()
                if (jwtProvider.needToRefresh(token)) {
                    token = jwtProvider.createJwt(userId)
                }
                val response = UserAvatarToken.newBuilder().setUser(user.toUserGrpc()).setToken(token).build()
                response.also { it ->
                    log.info("sign up: $it").also { span.tag("response", it.toString()) }
                }
            }
        }

    override suspend fun setOffline(request: Empty): IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(ChangeUserData)
            runWithTracing(span) {
                val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
                val user = userRepository.findById(userId).orElseThrow()
                user.copy(
                    isOnline = false
                ).also { userRepository.save(it) }
                successGrpc().also { it ->
                    log.info("sign up: $it").also { span.tag("response", it.toString()) }
                }
            }
        }

    override suspend fun getUserById(request: UserId): User =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(GetUserById)
            runWithTracing(span) {
                val user = userRepository.findById(request.id.uuid()).orElseThrow()
                user.toAnotherUser().also { it ->
                    log.info("sign up: $it").also { span.tag("response", it.toString()) }
                }
            }
        }

    @Transactional
    override suspend fun logOut(request: UserId): IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(LogOut)
            runWithTracing(span) {
                val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
                tokenRepository.deleteByUserId(userId)
                successGrpc().also { it ->
                    log.info("sign up: $it").also { span.tag("response", it.toString()) }
                }
            }
        }

    @Transactional
    override suspend fun changeUserData(request: User): IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(ChangeUserData)
            runWithTracing(span) {
                val user = userRepository.findById(request.id.uuid()).orElseThrow()
                user.copy(
                    name = request.name,
                    phone = request.phone,
                    address = request.address,
                    email = request.email,
                    notify = request.notify,
                    ).also { userRepository.save(it) }
                successGrpc().also { it ->
                    log.info("sign up: $it").also { span.tag("response", it.toString()) }
                }
            }
        }

    @Transactional
    override suspend fun deleteUser(request: Empty): IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(DeleteUser)
            runWithTracing(span) {
                val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
                userRepository.deleteById(userId)
                successGrpc().also { it ->
                    log.info("sign up: $it").also { span.tag("response", it.toString()) }
                }
            }
        }

    @Transactional
    override suspend fun addComment(request: UserOuterClass.Comment): IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(AddComment)
            runWithTracing(span) {
                val convicted = userRepository.findById(request.convicted.id.uuid()).orElseThrow()
                val creator = userRepository.findById(request.owner.id.uuid()).orElseThrow()
                val comment = request.fromCommentGrpc(convicted, creator)
                convicted.addComment(comment)
                userRepository.save(convicted)
                successGrpc().also { it ->
                    log.info("sign up: $it").also { span.tag("response", it.toString()) }
                }
            }
        }

    @Transactional
    override suspend fun editComment(request: UserOuterClass.Comment): IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(EditComment)
            runWithTracing(span) {
                val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
                if (userId != request.owner.id.uuid()) throw YouNotOwnerException()
                val comment = commentRepository.findById(request.id.uuid())
                    .orElseThrow { NotFoundException("Комментарий") }
                comment.copy(rating = request.rating, text = request.text)
                    .also { commentRepository.save(it) }
                successGrpc().also { it ->
                    log.info("sign up: $it").also { span.tag("response", it.toString()) }
                }
            }
        }

    @Transactional
    override suspend fun deleteComment(request: Id): IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(DeleteComment)
            runWithTracing(span) {
                commentRepository.deleteById(request.id.uuid())
                successGrpc().also { it ->
                    log.info("sign up: $it").also { span.tag("response", it.toString()) }
                }
            }
        }


    override suspend fun getComments(request: UserId): CommentsResponse =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(GetComments)
            runWithTracing(span) {
                val comments = commentRepository.findByConvictedId(request.id.uuid())
                comments.toRepeatedCommentGrpc().also { it ->
                    log.info("sign up: $it").also { span.tag("response", it.toString()) }
                }
            }
        }


    override suspend fun getUserComments(request: Empty): CommentsResponse =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(GetUserComments)
            runWithTracing(span) {
                val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
                val comments = commentRepository.findByCreatorId(userId)
                comments.toRepeatedCommentGrpc().also { it ->
                    log.info("sign up: $it").also { span.tag("response", it.toString()) }
                }
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
    }
}