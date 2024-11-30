package com.example.boardserver.delivery.grpc

import board.UserOuterClass.*
import brave.Tracer
import com.example.boardserver.entity.successGrpc
import com.example.boardserver.entity.uuid
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
    override suspend fun startSignUp(request: User): Id =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, GetSignUp) {
                userService.startSignUp(request)
                    .let { Id.newBuilder().setId(it.toString()).build() }
            }
        }

    @Transactional
    override suspend fun endSignUp(request: Code): IsSuccess =
        runWithTracing(tracer, GetSignUp) {
            successGrpc(userService.endSignUp(request.id.uuid(), request.code))
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
                userService.getUserAndRefresh()
            }
        }

    @Transactional
    override suspend fun setOffline(request: Empty): IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, SetOffline) {
                successGrpc(userService.setOffline())
            }
        }

    override suspend fun getUserById(request: Id): User =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, GetUserById) {
                userService.getUserById(request.id.uuid())
            }
        }

    @Transactional
    override suspend fun logOut(request: Empty): IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, LogOut) {
                successGrpc(userService.logOut())
            }
        }

    @Transactional
    override suspend fun changeUserData(request: User): IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, ChangeUserData) {
                successGrpc(userService.changeUserData(request))
            }
        }

    @Transactional
    override suspend fun setAvatar(request: ImageProto): IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, SetAvatar) {
                successGrpc(userService.setAvatar(request))
            }
        }

    @Transactional
    override suspend fun deleteUser(request: Empty): IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, DeleteUser) {
                successGrpc(userService.deleteUser())
            }
        }

    @Transactional
    override suspend fun addComment(request: Comment): IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, AddComment) {
                successGrpc(userService.addComment(request))
            }
        }

    @Transactional
    override suspend fun editComment(request: Comment): IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, EditComment) {
                successGrpc(userService.editComment(request))
            }
        }

    @Transactional
    override suspend fun deleteComment(request: Id): IsSuccess =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, DeleteComment) {
                successGrpc(userService.deleteComment(request.id.uuid()))
            }
        }


    override suspend fun getComments(request: Id): CommentsResponse =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, GetComments) {
                userService.getComments(request.id.uuid())
            }
        }


    override suspend fun getUserComments(request: Empty): CommentsResponse =
        withTimeout(timeOutMillis) {
            runWithTracing(tracer, GetUserComments) {
                userService.getUserComments()
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