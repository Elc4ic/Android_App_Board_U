package com.example.boardserver.service

import board.UserOuterClass
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
            responseObserver!!.onNext(UserUtils.failGrpc())
            responseObserver.onCompleted()
        }
        val newUser = UserOuterClass.User.newBuilder()
            .setUsername(request.username)
            .setPassword(UserUtils.hashPassword(request.password))
            .build()
        userRepository.save(UserUtils.fromUserGrpc(newUser))
        responseObserver!!.onNext(UserUtils.successGrpc())
        responseObserver.onCompleted()
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

    override fun changeUserData(
        request: UserOuterClass.SetUser?,
        responseObserver: StreamObserver<UserOuterClass.IsSuccess>?
    ) {
        super.changeUserData(request, responseObserver)
    }

    override fun deleteUser(
        request: UserOuterClass.JwtProto?,
        responseObserver: StreamObserver<UserOuterClass.IsSuccess>?
    ) {
        super.deleteUser(request, responseObserver)
    }
}