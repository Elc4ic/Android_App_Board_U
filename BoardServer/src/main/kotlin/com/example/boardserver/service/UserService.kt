package com.example.boardserver.service

import board.UserOuterClass
import board.UserOuterClass.UserResponse
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
        request: UserOuterClass.SignupRequest?,
        responseObserver: StreamObserver<UserOuterClass.IsSuccess>?
    ) {
        if (userRepository.findByUsername(request!!.username).isEmpty) {
            val newUser = UserOuterClass.User.newBuilder()
                .setName(request.username)
                .setUsername(request.username)
                .setPassword(UserUtils.hashPassword(request.password))
                .setPhone(request.phone)
                .build()
            val user =UserUtils.fromUserGrpc(newUser)
            userRepository.save(user)
            responseObserver?.onNext(UserUtils.successGrpc())
        } else {
            responseObserver?.onNext(UserUtils.failGrpc())
        }
        responseObserver?.onCompleted()
    }

    override fun getLogin(
        request: UserOuterClass.LoginRequest?,
        responseObserver: StreamObserver<UserOuterClass.LoginResponse>?
    ) {
        val user = userRepository.findByUsername(request!!.username).get()
        if (UserUtils.checkPassword(request.password, user.password)) {
            responseObserver!!.onNext(
                UserOuterClass.LoginResponse.newBuilder()
                    .setUser(UserUtils.toUserGrpc(user))
                    .setAccessToken(jwtProvider.createJwt(user.id))
                    .build()
            )
            tokenRepository.save(fcmProvider.createTokenEntity(user, request.deviceToken))
        } else {
            responseObserver!!.onError(Status.INVALID_ARGUMENT.withDescription("Неправильный ввод").asException())
        }
        responseObserver.onCompleted()
    }

    override fun getUserData(
        request: UserOuterClass.JwtProto?,
        responseObserver: StreamObserver<UserResponse>?
    ) {
        val userId = jwtProvider.validateJwt(request!!.token)
        if (userId != null) {
            val user = userRepository.findById(userId).get()
            responseObserver?.onNext(
                UserResponse.newBuilder().setUser(UserUtils.toUserGrpc(user)).build()
            )
        } else {
            responseObserver?.onError(Status.INVALID_ARGUMENT.withDescription("Неправильный токен").asException())
        }
        responseObserver?.onCompleted()
    }

    @Transactional
    override fun changeUserData(
        request: UserOuterClass.SetUser?,
        responseObserver: StreamObserver<UserOuterClass.IsSuccess>?
    ) {
        val userId = jwtProvider.validateJwt(request!!.token)
        if (userId != null) {
            userRepository.save(UserUtils.fromUserGrpc(request.user!!))
            responseObserver?.onNext(
                UserOuterClass.IsSuccess.newBuilder().setLogin(true).build()
            )
        } else {
            responseObserver?.onError(Status.INVALID_ARGUMENT.withDescription("Неправильный токен").asException())
        }
        responseObserver?.onCompleted()
    }

    @Transactional
    override fun deleteUser(
        request: UserOuterClass.JwtProto?,
        responseObserver: StreamObserver<UserOuterClass.IsSuccess>?
    ) {
        super.deleteUser(request, responseObserver)
    }

    override fun getUserById(
        request: UserOuterClass.GetByUserIdRequest?,
        responseObserver: StreamObserver<UserResponse>?
    ) {
        val user = userRepository.findById(request!!.id).get();
        responseObserver?.onNext(UserResponse.newBuilder().setUser(UserUtils.toUserGrpc(user)).build())
        responseObserver?.onCompleted()
    }

    @Transactional
    override fun addComment(
        request: UserOuterClass.CommentProto?,
        responseObserver: StreamObserver<UserOuterClass.IsSuccess>?
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
                UserOuterClass.IsSuccess.newBuilder().setLogin(true).build()
            )
        } else {
            responseObserver?.onError(Status.INVALID_ARGUMENT.withDescription("Неправильный токен").asException())
        }
        responseObserver?.onCompleted()
    }

    override fun getUserComments(
        request: UserOuterClass.JwtProto?,
        responseObserver: StreamObserver<UserOuterClass.CommentsResponse>?
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
        request: UserOuterClass.IdAndJwt?,
        responseObserver: StreamObserver<UserOuterClass.IsSuccess>?
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
                    UserOuterClass.IsSuccess.newBuilder().setLogin(true).build()
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
        request: UserOuterClass.GetByUserIdRequest?,
        responseObserver: StreamObserver<UserOuterClass.CommentsResponse>?
    ) {
        val comments = commentRepository.findByConvictedId(request!!.id)
        responseObserver?.onNext(CommentUtils.toRepeatedCommentGrpc(comments))
        responseObserver?.onCompleted()
    }

    @Transactional
    override fun editComment(
        request: UserOuterClass.EditCommentRequest?,
        responseObserver: StreamObserver<UserOuterClass.IsSuccess>?
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
                    UserOuterClass.IsSuccess.newBuilder().setLogin(true).build()
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