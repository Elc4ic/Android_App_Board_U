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
        val token: String? = headers.get(METADATA_TOKEN)
        val userId = jwtProvider.validateJwt(token!!)
        val authorize: Boolean = userId != null

        log.info("method: $methodName, authorize: $authorize, userId: $userId, token: $token")
        if (!authorize && methodName !in excludedMethods) {
            call.close(Status.UNAUTHENTICATED.withDescription("Invalid or missing token"), headers)
            return object : ServerCall.Listener<ReqT>() {}
        }
        val context = Context.current()
            .withValue(ContextKeys.TOKEN_KEY, token)
            .withValue(ContextKeys.AUTH_KEY, authorize.toString())
            .withValue(ContextKeys.USER_ID_KEY, userId.toString())
        return Contexts.interceptCall(context, call, headers, next)
    }

    companion object {
        private val log = LoggerFactory.getLogger(LogGrpcInterceptor::class.java)

        val METADATA_TOKEN: Metadata.Key<String> =
            Metadata.Key.of("token", Metadata.ASCII_STRING_MARSHALLER)
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
    val AUTH_KEY: Context.Key<String> = Context.key("authorize")
}

