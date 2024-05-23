package com.example.boardserver.service

import board.UserOuterClass
import com.example.boardserver.repository.UserRepository
import com.example.boardserver.utils.JwtProvider
import com.example.boardserver.utils.UserUtils
import io.grpc.Status
import io.grpc.stub.StreamObserver

class UserService(
    private val userRepository: UserRepository,
    private val jwtProvider: JwtProvider,
) : board.UserAPIGrpc.UserAPIImplBase() {

    override fun signUp(
        request: UserOuterClass.SignupRequestMessage?,
        responseObserver: StreamObserver<UserOuterClass.SignupResponseMessage>?
    ) {
        val passwordHash = UserUtils.hashPassword(request!!.password)
        val newUser = UserOuterClass.User.newBuilder()
            .setUsername(request.username)
            .setPassword(passwordHash)
            .build()
        userRepository.save(UserUtils.fromUserGrpc(newUser))
        responseObserver!!.onNext(UserOuterClass.SignupResponseMessage.newBuilder().setUser(newUser).build())
        responseObserver.onCompleted()
    }

    override fun login(
        request: UserOuterClass.LoginRequestMessage?,
        responseObserver: StreamObserver<UserOuterClass.LoginResponseMessage>?
    ) {
        val user = userRepository.findByUsername(request!!.username).get()
        if (UserUtils.checkPassword(request.password, user.password)) {
            responseObserver!!.onError(Status.INVALID_ARGUMENT.withDescription("Неправильный ввод").asException())
        } else {
            responseObserver!!.onNext(
                UserOuterClass.LoginResponseMessage.newBuilder()
                    .setUser(UserUtils.toUserGrpc(user))
                    .setAccessToken(jwtProvider.generateAccessToken(user))
                    .build()
            )
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
        request: UserOuterClass.TokenProto?,
        responseObserver: StreamObserver<UserOuterClass.IsSuccess>?
    ) {
        super.deleteUser(request, responseObserver)
    }
}