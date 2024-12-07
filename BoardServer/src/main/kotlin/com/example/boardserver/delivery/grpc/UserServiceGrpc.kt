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


@GrpcService(interceptors = [LogGrpcInterceptor::class])
class UserServiceGrpc(
    private val userService: UserService,
    private val tracer: Tracer
) : board.UserAPIGrpcKt.UserAPICoroutineImplBase() {

    override suspend fun startSignUp(request: User): Id =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(GetSignUp)
            runWithTracing(span) {
                userService.startSignUp(request)
                    .let { Id.newBuilder().setId(it.toString()).build() }.also { span.tag("response", it.toString()) }
            }
        }

    override suspend fun endSignUp(request: Code): IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(GetSignUp)
            runWithTracing(span) {
                successGrpc(userService.endSignUp(request.id.uuid(), request.code)).also {
                    span.tag(
                        "response",
                        it.toString()
                    )
                }
            }
        }

    override suspend fun getLogin(request: LoginRequest): LoginResponse =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(GetLogin)
            runWithTracing(span) {
                userService.getLogin(request).also { span.tag("response", it.toString()) }
            }
        }

    override suspend fun getUserAndRefresh(request: Empty): UserAvatarToken =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(GetUserAndRefresh)
            runWithTracing(span) {
                userService.getUserAndRefresh().also { span.tag("response", it.toString()) }
            }
        }

    override suspend fun setOffline(request: IsSuccess): IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(SetOffline)
            runWithTracing(span) {
                successGrpc(userService.setOffline(request.login)).also { span.tag("response", it.toString()) }
            }
        }

    override suspend fun getUserById(request: Id): User =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(GetUserById)
            runWithTracing(span) {
                userService.getUserById(request.id.uuid()).also { span.tag("response", it.toString()) }
            }
        }

    override suspend fun logOut(request: Empty): IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(LogOut)
            runWithTracing(span) {
                successGrpc(userService.logOut()).also { span.tag("response", it.toString()) }
            }
        }

    override suspend fun changeUserData(request: User): IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(ChangeUserData)
            runWithTracing(span) {
                successGrpc(userService.changeUserData(request)).also { span.tag("response", it.toString()) }
            }
        }

    override suspend fun setAvatar(request: ImageProto): IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(SetAvatar)
            runWithTracing(span) {
                successGrpc(userService.setAvatar(request)).also { span.tag("response", it.toString()) }
            }
        }

    override suspend fun deleteUser(request: Empty): IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(DeleteUser)
            runWithTracing(span) {
                successGrpc(userService.deleteUser()).also { span.tag("response", it.toString()) }
            }
        }

    override suspend fun addComment(request: Comment): IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(AddComment)
            runWithTracing(span) {
                successGrpc(userService.addComment(request)).also { span.tag("response", it.toString()) }
            }
        }

    override suspend fun deleteComment(request: Id): IsSuccess =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(DeleteComment)
            runWithTracing(span) {
                successGrpc(userService.deleteComment(request.id.uuid())).also { span.tag("response", it.toString()) }
            }
        }


    override suspend fun getComments(request: Id): CommentsResponse =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(GetComments)
            runWithTracing(span) {
                userService.getComments(request.id.uuid()).also { span.tag("response", it.toString()) }
            }
        }


    override suspend fun getUserComments(request: Empty): CommentsResponse =
        withTimeout(timeOutMillis) {
            val span = tracer.startScopedSpan(GetUserComments)
            runWithTracing(span) {
                userService.getUserComments().also { span.tag("response", it.toString()) }
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