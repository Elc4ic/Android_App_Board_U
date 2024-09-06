package com.example.boardserver.service

import board.UserOuterClass.*
import com.example.boardserver.repository.CommentRepository
import com.example.boardserver.repository.TokenRepository
import com.example.boardserver.repository.UserRepository
import com.example.boardserver.utils.CommentUtils
import com.example.boardserver.utils.FcmProvider
import com.example.boardserver.utils.JwtProvider
import com.example.boardserver.utils.UserUtils
import io.grpc.Status
import io.grpc.stub.StreamObserver
import net.devh.boot.grpc.server.service.GrpcService
import org.springframework.transaction.annotation.Transactional

@GrpcService
class UserService(
    private val userRepository: UserRepository,
    private val commentRepository: CommentRepository,
    private val tokenRepository: TokenRepository,
    private val jwtProvider: JwtProvider,
    private val fcmProvider: FcmProvider
) : board.UserAPIGrpc.UserAPIImplBase() {

    @Transactional
    override fun getSignUp(
        request: SignupRequest?,
        responseObserver: StreamObserver<IsSuccess>?
    ) {
        if (userRepository.findByUsername(request!!.username).isEmpty) {
            val newUser = User.newBuilder()
                .setName(request.username)
                .setUsername(request.username)
                .setPassword(UserUtils.hashPassword(request.password))
                .setPhone(request.phone)
                .build()
            val user = UserUtils.fromUserGrpc(newUser)
            userRepository.save(user)
            responseObserver?.onNext(UserUtils.successGrpc())
        } else {
            responseObserver?.onNext(UserUtils.failGrpc())
        }
        responseObserver?.onCompleted()
    }

    override fun getLogin(
        request: LoginRequest?,
        responseObserver: StreamObserver<LoginResponse>?
    ) {
        val user = userRepository.findByUsername(request!!.username).get()
        if (UserUtils.checkPassword(request.password, user.password)) {
            responseObserver!!.onNext(
                LoginResponse.newBuilder()
                    .setUser(UserUtils.toUserGrpc(user))
                    .setAccessToken(jwtProvider.createJwt(user.id))
                    .build()
            )
            println(request.deviceToken)
            tokenRepository.save(fcmProvider.createTokenEntity(user, request.deviceToken))
        } else {
            responseObserver!!.onError(Status.INVALID_ARGUMENT.withDescription("Неправильный ввод").asException())
        }
        responseObserver.onCompleted()
    }

    @Transactional
    override fun logOut(
        request: UserId?,
        responseObserver: StreamObserver<IsSuccess>?
    ) {
        tokenRepository.deleteByUserId(request!!.id)
        responseObserver?.onNext(UserUtils.successGrpc())
        responseObserver?.onCompleted()
    }

    override fun getUserAndRefresh(
        request: JwtProto?,
        responseObserver: StreamObserver<UserToken>?
    ) {
        val userId = jwtProvider.validateJwt(request!!.token)
        if (userId != null) {
            var token = request.token
            val user = userRepository.findById(userId).get()
            if(jwtProvider.needToRefresh(request.token)) {
                token = jwtProvider.createJwt(user.id)
            }
            responseObserver?.onNext(
                UserToken.newBuilder().setUser(UserUtils.toUserGrpc(user)).setToken(token).build()
            )
        } else {
            responseObserver?.onError(Status.INVALID_ARGUMENT.withDescription("Неправильный токен").asException())
        }
        responseObserver?.onCompleted()
    }

    @Transactional
    override fun changeUserData(
        request: UserToken?,
        responseObserver: StreamObserver<IsSuccess>?
    ) {
        val userId = jwtProvider.validateJwt(request!!.token)
        if (userId != null) {
            userRepository.save(UserUtils.fromUserGrpc(request.user!!))
            responseObserver?.onNext(
                IsSuccess.newBuilder().setLogin(true).build()
            )
        } else {
            responseObserver?.onError(Status.INVALID_ARGUMENT.withDescription("Неправильный токен").asException())
        }
        responseObserver?.onCompleted()
    }

    @Transactional
    override fun deleteUser(
        request: JwtProto?,
        responseObserver: StreamObserver<IsSuccess>?
    ) {
        super.deleteUser(request, responseObserver)
    }

    override fun getUserById(
        request: UserId?,
        responseObserver: StreamObserver<UserToken>?
    ) {
        val user = userRepository.findById(request!!.id).get();
        responseObserver?.onNext(UserToken.newBuilder().setUser(UserUtils.toUserGrpc(user)).build())
        responseObserver?.onCompleted()
    }

    @Transactional
    override fun addComment(
        request: CommentProto?,
        responseObserver: StreamObserver<IsSuccess>?
    ) {
        val userId = jwtProvider.validateJwt(request!!.token)
        if (userId != null) {
            val convicted = userRepository.findById(request.comment.convicted.id).get()
            val owner = userRepository.findById(request.comment.owner.id).get()
            convicted.ratingAll += request.comment.rating
            convicted.ratingNum++
            userRepository.save(convicted)
            commentRepository.save(
                CommentUtils.fromCommentGrpc(
                    request.comment,
                    owner,
                    convicted
                )
            )
            responseObserver?.onNext(
                IsSuccess.newBuilder().setLogin(true).build()
            )
        } else {
            responseObserver?.onError(Status.INVALID_ARGUMENT.withDescription("Неправильный токен").asException())
        }
        responseObserver?.onCompleted()
    }

    override fun getUserComments(
        request: JwtProto?,
        responseObserver: StreamObserver<CommentsResponse>?
    ) {
        val userId = jwtProvider.validateJwt(request!!.token)
        if (userId != null) {
            val comments = commentRepository.findByOwnerId(userId)
            responseObserver?.onNext(CommentUtils.toRepeatedCommentGrpc(comments))
        } else {
            responseObserver?.onError(Status.INVALID_ARGUMENT.withDescription("Неправильный токен").asException())
        }
        responseObserver?.onCompleted()
    }

    @Transactional
    override fun deleteComment(
        request: IdToken?,
        responseObserver: StreamObserver<IsSuccess>?
    ) {
        val userId = jwtProvider.validateJwt(request!!.token)
        if (userId != null) {
            val comment = commentRepository.findById(request.id).get()
            if (userId == comment.owner.id) {
                val user = userRepository.findById(comment.convicted.id).get()
                user.ratingAll -= comment.rating
                user.ratingNum--
                userRepository.save(user)
                commentRepository.delete(comment)
                responseObserver?.onNext(
                    IsSuccess.newBuilder().setLogin(true).build()
                )
            } else {
                responseObserver?.onError(
                    Status.INVALID_ARGUMENT.withDescription("Вы не владеёте этим комментарием").asException()
                )
            }
        } else {
            responseObserver?.onError(Status.INVALID_ARGUMENT.withDescription("Неправильный токен").asException())
        }
        responseObserver?.onCompleted()
    }

    override fun getComments(
        request: UserId?,
        responseObserver: StreamObserver<CommentsResponse>?
    ) {
        val comments = commentRepository.findByConvictedId(request!!.id)
        responseObserver?.onNext(CommentUtils.toRepeatedCommentGrpc(comments))
        responseObserver?.onCompleted()
    }

    @Transactional
    override fun editComment(
        request: EditCommentRequest?,
        responseObserver: StreamObserver<IsSuccess>?
    ) {
        val userId = jwtProvider.validateJwt(request!!.token)
        if (userId != null) {
            if (userId == request.comment.owner.id) {
                val convicted = userRepository.findById(request.comment.convicted.id).get()
                val owner = userRepository.findById(request.comment.owner.id).get()
                convicted.ratingAll += request.comment.rating
                convicted.ratingAll -= request.ratingPrev
                userRepository.save(convicted)
                commentRepository.save(CommentUtils.fromCommentGrpc(request.comment, owner, convicted))
                responseObserver?.onNext(
                    IsSuccess.newBuilder().setLogin(true).build()
                )
            } else {
                responseObserver?.onError(
                    Status.INVALID_ARGUMENT.withDescription("Вы не владеёте этим комментарием").asException()
                )
            }
        } else {
            responseObserver?.onError(Status.INVALID_ARGUMENT.withDescription("Неправильный токен").asException())
        }
        responseObserver?.onCompleted()
    }
}