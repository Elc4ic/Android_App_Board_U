package com.example.boardserver.service

import board.UserOuterClass.*
import board.UserOuterClass.User
import com.example.boardserver.entity.*
import com.example.boardserver.interceptor.ContextKeys
import com.example.boardserver.interceptor.LogGrpcInterceptor
import com.example.boardserver.repository.*
import com.example.boardserver.utils.FcmProvider
import com.example.boardserver.utils.JwtProvider
import com.example.boardserver.utils.runWithTracing
import io.grpc.Context
import io.grpc.Status
import io.opentelemetry.api.trace.Tracer
import io.opentelemetry.extension.kotlin.asContextElement
import jakarta.transaction.Transactional
import kotlinx.coroutines.withContext
import kotlinx.coroutines.withTimeout
import net.devh.boot.grpc.server.service.GrpcService
import org.slf4j.LoggerFactory


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

    override suspend fun getSignUp(request: SignupRequest): IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.spanBuilder(GetSignUp).startSpan()
            withContext(span.asContextElement()) {
                runWithTracing(span) {
                    if (userRepository.countByPhone(request.phone) == 0) {
                        if (userRepository.countByUsername(request.username) == 0) {
                            val newUser = User.newBuilder().setName(request.username).setUsername(request.username)
                                .setPassword(request.password.hashPassword()).setPhone(request.phone).build()
                            val user = newUser.fromUserGrpc()
                            userRepository.save(user)
                            successGrpc().also { it ->
                                log.info("sign up: $it").also { span.setAttribute("response", it.toString()) }
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
        }


    override suspend fun getLogin(request: LoginRequest): LoginResponse =
        withTimeout(timeOutMillis) {
            val span = tracer.spanBuilder(GetLogin).startSpan()
            withContext(span.asContextElement()) {
                runWithTracing(span) {
                    if (userRepository.countByUsername(request.username) != 0) {
                        val user = userRepository.findByUsername(request.username).get()
                        if (request.password.checkPassword(user.password)) {
                            val response = LoginResponse.newBuilder().setUser(user.toUserGrpc())
                                .setAccessToken(jwtProvider.createJwt(user.id)).build()
                            tokenRepository.deleteByUserId(user.id)
                            tokenRepository.save(fcmProvider.createTokenEntity(user, request.deviceToken))
                            response.also { it ->
                                log.info("sign up: $it").also { span.setAttribute("response", it.toString()) }
                            }
                        } else {
                            throw Status.INVALID_ARGUMENT.withDescription("Неправильный пароль").asException()
                        }
                    } else {
                        throw Status.INVALID_ARGUMENT.withDescription("Пользователь не найден").asException()
                    }
                }
            }

        }


    override suspend fun getUserAndRefresh(request: Empty): UserToken =
        withTimeout(timeOutMillis) {
            val span = tracer.spanBuilder(GetUserAndRefresh).startSpan()
            withContext(span.asContextElement()) {
                runWithTracing(span) {
                    val userId = ContextKeys.USER_ID_KEY.get(Context.current()).toLong()
                    var token = ContextKeys.TOKEN_KEY.get(Context.current())
                    val user = userRepository.findById(userId).get()
                    if (jwtProvider.needToRefresh(token)) {
                        token = jwtProvider.createJwt(user.id)
                    }
                    val response = UserToken.newBuilder().setUser(user.toUserGrpc()).setToken(token).build()
                    response.also { it ->
                        log.info("sign up: $it").also { span.setAttribute("response", it.toString()) }
                    }
                }
            }

        }


    override suspend fun getUserById(request: UserId): UserToken =
        withTimeout(timeOutMillis) {
            val span = tracer.spanBuilder(GetUserById).startSpan()
            withContext(span.asContextElement()) {
                runWithTracing(span) {
                    val user = userRepository.findById(request.id).get()
                    val response = UserToken.newBuilder().setUser(user.toAnotherUser()).build()
                    response.also { it ->
                        log.info("sign up: $it").also { span.setAttribute("response", it.toString()) }
                    }
                }
            }
        }

    override suspend fun logOut(request: UserId): IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.spanBuilder(LogOut).startSpan()
            withContext(span.asContextElement()) {
                runWithTracing(span) {
                    tokenRepository.deleteByUserId(request.id)
                    successGrpc().also { it ->
                        log.info("sign up: $it").also { span.setAttribute("response", it.toString()) }
                    }
                }
            }
        }

    @Transactional
    override suspend fun changeUserData(request: UserToken): IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.spanBuilder(ChangeUserData).startSpan()
            withContext(span.asContextElement()) {
                runWithTracing(span) {
                    userRepository.save(request.user!!.fromUserGrpc())
                    successGrpc().also { it ->
                        log.info("sign up: $it").also { span.setAttribute("response", it.toString()) }
                    }
                }
            }
        }

    @Transactional
    override suspend fun deleteUser(request: Empty): IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.spanBuilder(DeleteUser).startSpan()
            withContext(span.asContextElement()) {
                runWithTracing(span) {
                    val userId = ContextKeys.USER_ID_KEY.get(Context.current()).toLong()
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
                    successGrpc().also { it ->
                        log.info("sign up: $it").also { span.setAttribute("response", it.toString()) }
                    }
                }
            }
        }

    @Transactional
    override suspend fun addComment(request: CommentProto): IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.spanBuilder(AddComment).startSpan()
            withContext(span.asContextElement()) {
                runWithTracing(span) {
                    val convicted = userRepository.findById(request.comment.convicted.id).get()
                    val owner = userRepository.findById(request.comment.owner.id).get()
                    convicted.ratingAll += request.comment.rating
                    convicted.ratingNum++
                    userRepository.save(convicted)
                    commentRepository.save(
                        request.comment.fromCommentGrpc(owner, convicted)
                    )
                    successGrpc().also { it ->
                        log.info("sign up: $it").also { span.setAttribute("response", it.toString()) }
                    }
                }
            }
        }

    @Transactional
    override suspend fun editComment(request: EditCommentRequest): IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.spanBuilder(EditComment).startSpan()
            withContext(span.asContextElement()) {
                runWithTracing(span) {
                    val userId = ContextKeys.USER_ID_KEY.get(Context.current()).toLong()
                    if (userId == request.comment.owner.id) {
                        val convicted = userRepository.findById(request.comment.convicted.id).get()
                        val owner = userRepository.findById(request.comment.owner.id).get()
                        convicted.ratingAll += request.comment.rating
                        convicted.ratingAll -= request.ratingPrev
                        userRepository.save(convicted)
                        commentRepository.save(request.comment.fromCommentGrpc(owner, convicted))

                    } else {
                        throw Status.INVALID_ARGUMENT.withDescription("Вы не владеёте этим комментарием").asException()
                    }
                    successGrpc().also { it ->
                        log.info("sign up: $it").also { span.setAttribute("response", it.toString()) }
                    }
                }
            }
        }

    override suspend fun deleteComment(request: Id): IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.spanBuilder(DeleteComment).startSpan()
            withContext(span.asContextElement()) {
                runWithTracing(span) {
                    val userId = ContextKeys.USER_ID_KEY.get(Context.current()).toLong()
                    val comment = commentRepository.findById(request.id).get()
                    if (userId == comment.creator.id) {
                        val user = userRepository.findById(comment.convicted.id).get()
                        user.ratingAll -= comment.rating
                        user.ratingNum--
                        userRepository.save(user)
                        commentRepository.delete(comment)

                    } else {
                        throw Status.INVALID_ARGUMENT.withDescription("Вы не владеёте этим комментарием").asException()
                    }
                    successGrpc().also { it ->
                        log.info("sign up: $it").also { span.setAttribute("response", it.toString()) }
                    }
                }
            }
        }


    override suspend fun getComments(request: UserId): CommentsResponse =
        withTimeout(timeOutMillis) {
            val span = tracer.spanBuilder(GetComments).startSpan()
            withContext(span.asContextElement()) {
                runWithTracing(span) {
                    val comments = commentRepository.findByConvictedId(request.id)
                    comments.toRepeatedCommentGrpc().also { it ->
                        log.info("sign up: $it").also { span.setAttribute("response", it.toString()) }
                    }
                }
            }
        }


    override suspend fun getUserComments(request: Empty): CommentsResponse =
        withTimeout(timeOutMillis) {
            val span = tracer.spanBuilder(GetUserComments).startSpan()
            withContext(span.asContextElement()) {
                runWithTracing(span) {
                    val userId = ContextKeys.USER_ID_KEY.get(Context.current()).toLong()
                    val comments = commentRepository.findByCreatorId(userId)
                    comments.toRepeatedCommentGrpc().also { it ->
                        log.info("sign up: $it").also { span.setAttribute("response", it.toString()) }
                    }
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