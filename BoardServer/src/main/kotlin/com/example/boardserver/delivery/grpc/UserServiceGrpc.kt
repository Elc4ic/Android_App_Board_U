package com.example.boardserver.delivery.grpc

import board.UserOuterClass.*
import brave.Tracer
import com.example.boardserver.interceptor.LogGrpcInterceptor
import com.example.boardserver.service.UserService
import com.example.boardserver.utils.runWithTracing
import kotlinx.coroutines.withTimeout
import net.devh.boot.grpc.server.service.GrpcService
import org.slf4j.LoggerFactory
import org.springframework.transaction.annotation.Transactional


@GrpcService(interceptors = [LogGrpcInterceptor::class])
class UserServiceGrpc(
    private val userService: UserService,
    private val tracer: Tracer
) : board.UserAPIGrpcKt.UserAPICoroutineImplBase() {

    @Transactional
    override suspend fun startSignUp(request: SignupRequest): User =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, GetSignUp) {
                userService.startSignUp(request)
            }
        }

    @Transactional
    override suspend fun endSignUp(request: UserId): IsSuccess =
        runWithTracing(tracer, GetSignUp) {
            userService.endSignUp(request)
        }


    @Transactional
    override suspend fun getLogin(request: LoginRequest): LoginResponse =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, GetLogin) {
                userService.getLogin(request)
            }
        }

    @Transactional
    override suspend fun getUserAndRefresh(request: Empty): UserAvatarToken =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, GetUserAndRefresh) {
                userService.getUserAndRefresh(request)
            }
        }

    @Transactional
    override suspend fun setOffline(request: Empty): IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, SetOffline) {
                userService.setOffline(request)
            }
        }

    override suspend fun getUserById(request: UserId): User =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, GetUserById) {
                userService.getUserById(request)
            }
        }

    @Transactional
    override suspend fun logOut(request: Empty): IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, LogOut) {
                userService.logOut(request)
            }
        }

    @Transactional
    override suspend fun changeUserData(request: User): IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, ChangeUserData) {
                userService.changeUserData(request)
            }
        }

    @Transactional
    override suspend fun setAvatar(request: ImageProto): IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, SetAvatar) {
                userService.setAvatar(request)
            }
        }

    @Transactional
    override suspend fun deleteUser(request: Empty): IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, DeleteUser) {
                userService.deleteUser(request)
            }
        }

    @Transactional
    override suspend fun addComment(request: Comment): IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, AddComment) {
                userService.addComment(request)
            }
        }

    @Transactional
    override suspend fun editComment(request: Comment): IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, EditComment) {
                userService.editComment(request)
            }
        }

    @Transactional
    override suspend fun deleteComment(request: Id): IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, DeleteComment) {
                userService.deleteComment(request)
            }
        }


    override suspend fun getComments(request: UserId): CommentsResponse =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, GetComments) {
                userService.getComments(request)
            }
        }


    override suspend fun getUserComments(request: Empty): CommentsResponse =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, GetUserComments) {
                userService.getUserComments(request)
            }
        }

    companion object {
        private val log = LoggerFactory.getLogger(UserServiceGrpc::class.java)
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