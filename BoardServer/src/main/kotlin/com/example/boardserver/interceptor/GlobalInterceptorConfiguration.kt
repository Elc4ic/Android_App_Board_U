package com.example.boardserver.interceptor

import com.example.boardserver.utils.JwtProvider
import net.devh.boot.grpc.server.interceptor.GrpcGlobalServerInterceptor
import org.springframework.context.annotation.Configuration

@Configuration(proxyBeanMethods = false)
class GlobalInterceptorConfiguration(
    private val jwtProvider: JwtProvider
) {

    @GrpcGlobalServerInterceptor
    fun logServerInterceptor(): LogGrpcInterceptor? = LogGrpcInterceptor(jwtProvider)
}