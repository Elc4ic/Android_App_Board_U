package com.example.boardserver.interceptor

import com.example.boardserver.utils.JwtProvider
import io.grpc.*
import org.slf4j.LoggerFactory

class LogGrpcInterceptor(
    private val jwtProvider: JwtProvider
) : ServerInterceptor {

    override fun <ReqT : Any?, RespT : Any?> interceptCall(
        call: ServerCall<ReqT, RespT>,
        headers: Metadata,
        next: ServerCallHandler<ReqT, RespT>
    ): ServerCall.Listener<ReqT> {

        val methodName = call.methodDescriptor.fullMethodName
        val token = headers.get(METADATA_TOKEN)
        val userId = jwtProvider.validateJwt(token!!)

        headers.put(USER_ID, userId.toString())
        log.info("Service: ${methodName}, userId: $userId, token: $token")
        if (userId == null && methodName !in excludedMethods) {
            call.close(Status.UNAUTHENTICATED.withDescription("Invalid or missing token"), headers)
            return object : ServerCall.Listener<ReqT>() {}
        }
        val context = Context.current()
            .withValue(ContextKeys.USER_ID_KEY, userId.toString())
            .withValue(ContextKeys.TOKEN_KEY, token)

        return Contexts.interceptCall(context, call, headers, next)
    }

    companion object {
        private val log = LoggerFactory.getLogger(LogGrpcInterceptor::class.java)

        val METADATA_TOKEN: Metadata.Key<String> =
            Metadata.Key.of("token", Metadata.ASCII_STRING_MARSHALLER)
        val USER_ID: Metadata.Key<String> =
            Metadata.Key.of("userId", Metadata.ASCII_STRING_MARSHALLER)
        private val excludedMethods = listOf(
            "board.AdAPI/GetManyAd",
            "board.AdAPI/GetOneAd",
            "board.AdAPI/GetByUserId",
            "board.AdAPI/LoadImage",
            "board.CategoryAPI/GetAllCategories",
            "board.UserAPI/GetLogin",
            "board.UserAPI/GetSignUp",
            "board.UserAPI/GetUserById",
            "board.UserAPI/GetComment",
        )
    }

}

object ContextKeys {
    val USER_ID_KEY: Context.Key<String> = Context.key("userId")
    val TOKEN_KEY: Context.Key<String> = Context.key("token")
}

