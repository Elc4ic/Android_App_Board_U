package com.example.boardserver.service

import board.UserOuterClass
import board.UserOuterClass.UserResponse
import com.example.boardserver.repository.UserRepository
import com.example.boardserver.utils.JwtProvider
import com.example.boardserver.utils.UserUtils
import io.grpc.Status
import io.grpc.stub.StreamObserver
import net.devh.boot.grpc.server.service.GrpcService

@GrpcService
class UserService(
    private val userRepository: UserRepository,
    private val jwtProvider: JwtProvider,
) : board.UserAPIGrpc.UserAPIImplBase() {

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
            userRepository.save(UserUtils.fromUserGrpc(newUser))
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
}