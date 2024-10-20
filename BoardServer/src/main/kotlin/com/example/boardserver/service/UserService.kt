package com.example.boardserver.service

import board.UserOuterClass.*
import com.example.boardserver.interceptor.LogGrpcInterceptor
import com.example.boardserver.repository.*
import com.example.boardserver.utils.*
import io.grpc.Status
import io.micrometer.tracing.Tracer
import kotlinx.coroutines.withTimeout
import net.devh.boot.grpc.server.service.GrpcService
import org.slf4j.LoggerFactory
import org.springframework.transaction.annotation.Transactional


@GrpcService(interceptors = [LogGrpcInterceptor::class])
class UserService(
    private val userRepository: UserRepository,
    private val commentRepository: CommentRepository,
    private val favRepository: FavoritesRepository,
    private val imageRepository: ImageRepository,
    private val chatRepository: ChatRepository,
    private val messageRepository: MessageRepository,
    private val adRepository: AdRepository,
    private val tokenRepository: TokenRepository,
    private val jwtProvider: JwtProvider,
    private val fcmProvider: FcmProvider,
    private val tracer: Tracer
) : board.UserAPIGrpcKt.UserAPICoroutineImplBase() {

    @Transactional
    override suspend fun getSignUp(request: SignupRequest): IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(GetSignUp)

            if (userRepository.countByPhone(request.phone) == 0) {
                if (userRepository.countByUsername(request.username) == 0) {
                    val newUser = User.newBuilder().setName(request.username).setUsername(request.username)
                        .setPassword(UserUtils.hashPassword(request.password)).setPhone(request.phone).build()
                    val user = UserUtils.fromUserGrpc(newUser)
                    userRepository.save(user)
                    val response = UserUtils.successGrpc()
                    runWithTracing(span) {
                        response.also { it ->
                            log.info("sign up: $it").also { span.tag("response", it.toString()) }
                        }
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


    @Transactional
    override suspend fun getLogin(request: LoginRequest): LoginResponse =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(GetLogin)

            if (userRepository.countByUsername(request.username) != 0) {
                val user = userRepository.findByUsername(request.username).get()
                if (UserUtils.checkPassword(request.password, user.password)) {
                    val response = LoginResponse.newBuilder().setUser(UserUtils.toUserGrpc(user))
                        .setAccessToken(jwtProvider.createJwt(user.id)).build()
                    tokenRepository.deleteByUserId(user.id)
                    tokenRepository.save(fcmProvider.createTokenEntity(user, request.deviceToken))
                    runWithTracing(span) {
                        response.also { it ->
                            log.info("sign up: $it").also { span.tag("response", it.toString()) }
                        }
                    }
                } else {
                    throw Status.INVALID_ARGUMENT.withDescription("Неправильный пароль").asException()
                }
            } else {
                throw Status.INVALID_ARGUMENT.withDescription("Пользователь не найден").asException()
            }
        }


    override suspend fun getUserAndRefresh(request: JwtProto): UserToken =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(GetUserAndRefresh)

            val userId = jwtProvider.validateJwt(request.token)
            if (userId != null) {
                var token = request.token
                val user = userRepository.findById(userId).get()
                if (jwtProvider.needToRefresh(request.token)) {
                    token = jwtProvider.createJwt(user.id)
                }
                val response = UserToken.newBuilder().setUser(UserUtils.toUserGrpc(user)).setToken(token).build()
                runWithTracing(span) {
                    response.also { it ->
                        log.info("sign up: $it").also { span.tag("response", it.toString()) }
                    }
                }
            } else {
                throw Status.INVALID_ARGUMENT.withDescription("Неправильный токен").asException()
            }
        }


    override suspend fun getUserById(request: UserId): UserToken =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(GetUserById)

            val user = userRepository.findById(request.id).get()
            val response = UserToken.newBuilder().setUser(UserUtils.toUserGrpc(user)).build()
            runWithTracing(span) {
                response.also { it ->
                    log.info("sign up: $it").also { span.tag("response", it.toString()) }
                }
            }

        }

    @Transactional
    override suspend fun logOut(request: UserId): IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(LogOut)

            tokenRepository.deleteByUserId(request.id)
            val response = UserUtils.successGrpc()
            runWithTracing(span) {
                response.also { it ->
                    log.info("sign up: $it").also { span.tag("response", it.toString()) }
                }
            }
        }

    @Transactional
    override suspend fun changeUserData(request: UserToken): IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(ChangeUserData)

            val userId = jwtProvider.validateJwt(request.token)
            if (userId != null) {
                userRepository.save(UserUtils.fromUserGrpc(request.user!!))
                val response = UserUtils.successGrpc()
                runWithTracing(span) {
                    response.also { it ->
                        log.info("sign up: $it").also { span.tag("response", it.toString()) }
                    }
                }
            } else {
                throw Status.INVALID_ARGUMENT.withDescription("Неправильный токен").asException()
            }
        }

    @Transactional
    override suspend fun deleteUser(request: JwtProto): IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(DeleteUser)
            val userId = jwtProvider.validateJwt(request.token)
            if (userId != null) {
                favRepository.deleteAllByUserId(userId)
                val ad = adRepository.findByUserId(userId)
                ad.forEach {
                    imageRepository.deleteAllByAdId(it.id)
                    adRepository.deleteById(it.id)
                }
                val chats = chatRepository.findAllByOwnerIdOrReceiverId(userId, userId)
                chats.forEach {
                    messageRepository.deleteAllByChatId(it.id);
                    chatRepository.delete(it)
                }
                commentRepository.deleteByCreatorId(userId)
                userRepository.deleteById(userId)
                tokenRepository.deleteByUserId(userId)
                val response = UserUtils.successGrpc()
                runWithTracing(span) {
                    response.also { it ->
                        log.info("sign up: $it").also { span.tag("response", it.toString()) }
                    }
                }
            } else {
                throw Status.INVALID_ARGUMENT.withDescription("Неправильный токен").asException()
            }
        }

    @Transactional
    override suspend fun addComment(request: CommentProto): IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(AddComment)

            val userId = jwtProvider.validateJwt(request.token)
            if (userId != null) {
                val convicted = userRepository.findById(request.comment.convicted.id).get()
                val owner = userRepository.findById(request.comment.owner.id).get()
                convicted.ratingAll += request.comment.rating
                convicted.ratingNum++
                userRepository.save(convicted)
                commentRepository.save(
                    CommentUtils.fromCommentGrpc(
                        request.comment, owner, convicted
                    )
                )
                val response = IsSuccess.newBuilder().setLogin(true).build()
                runWithTracing(span) {
                    response.also { it ->
                        log.info("sign up: $it").also { span.tag("response", it.toString()) }
                    }
                }
            } else {
                throw Status.INVALID_ARGUMENT.withDescription("Неправильный токен").asException()
            }

        }

    @Transactional
    override suspend fun editComment(request: EditCommentRequest): IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(EditComment)

            val userId = jwtProvider.validateJwt(request.token)
            if (userId != null) {
                if (userId == request.comment.owner.id) {
                    val convicted = userRepository.findById(request.comment.convicted.id).get()
                    val owner = userRepository.findById(request.comment.owner.id).get()
                    convicted.ratingAll += request.comment.rating
                    convicted.ratingAll -= request.ratingPrev
                    userRepository.save(convicted)
                    commentRepository.save(CommentUtils.fromCommentGrpc(request.comment, owner, convicted))
                    val response = IsSuccess.newBuilder().setLogin(true).build()
                    runWithTracing(span) {
                        response.also { it ->
                            log.info("sign up: $it").also { span.tag("response", it.toString()) }
                        }
                    }
                } else {
                    throw Status.INVALID_ARGUMENT.withDescription("Вы не владеёте этим комментарием").asException()
                }
            } else {
                throw Status.INVALID_ARGUMENT.withDescription("Неправильный токен").asException()
            }

        }

    @Transactional
    override suspend fun deleteComment(request: IdToken): IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(DeleteComment)

            val userId = jwtProvider.validateJwt(request.token)
            if (userId != null) {
                val comment = commentRepository.findById(request.id).get()
                if (userId == comment.creator.id) {
                    val user = userRepository.findById(comment.convicted.id).get()
                    user.ratingAll -= comment.rating
                    user.ratingNum--
                    userRepository.save(user)
                    commentRepository.delete(comment)
                    val response = IsSuccess.newBuilder().setLogin(true).build()
                    runWithTracing(span) {
                        response.also { it ->
                            log.info("sign up: $it").also { span.tag("response", it.toString()) }
                        }
                    }
                } else {
                    throw Status.INVALID_ARGUMENT.withDescription("Вы не владеёте этим комментарием").asException()
                }
            } else {
                throw Status.INVALID_ARGUMENT.withDescription("Неправильный токен").asException()
            }
        }


    override suspend fun getComments(request: UserId): CommentsResponse =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(GetComments)

            val comments = commentRepository.findByConvictedId(request.id)
            val response = CommentUtils.toRepeatedCommentGrpc(comments)
            runWithTracing(span) {
                response.also { it ->
                    log.info("sign up: $it").also { span.tag("response", it.toString()) }
                }
            }
        }


    override suspend fun getUserComments(request: JwtProto): CommentsResponse =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(GetUserComments)

            val userId = jwtProvider.validateJwt(request.token)
            if (userId != null) {
                val comments = commentRepository.findByCreatorId(userId)
                val response = CommentUtils.toRepeatedCommentGrpc(comments)
                runWithTracing(span) {
                    response.also { it ->
                        log.info("sign up: $it").also { span.tag("response", it.toString()) }
                    }
                }
            } else {
                throw Status.INVALID_ARGUMENT.withDescription("Неправильный токен").asException()
            }
        }

    companion object {
        private val log = LoggerFactory.getLogger(UserService::class.java)
        private const val timeOutMillis = 5000L

        private const val GetSignUp = "UserService.getSignUp"
        private const val GetLogin = "UserService.getLogin"
        private const val GetUserAndRefresh = "UserService.getGetUserAndRefresh"
        private const val GetUserById = "UserService.getUserById"
        private const val LogOut = "UserService.logOut"
        private const val ChangeUserData = "UserService.changeUserData"
        private const val DeleteUser = "UserService.deleteUser"
        private const val AddComment = "UserService.addComment"
        private const val EditComment = "UserService.editComment"
        private const val DeleteComment = "UserService.deleteComment"
        private const val GetComments = "UserService.getComment"
        private const val GetUserComments = "UserService.getUserComment"
    }
}