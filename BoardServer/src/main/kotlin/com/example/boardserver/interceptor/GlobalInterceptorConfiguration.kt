package com.example.boardserver.interceptor

import net.devh.boot.grpc.server.interceptor.GrpcGlobalServerInterceptor
import org.springframework.context.annotation.Configuration

@Configuration(proxyBeanMethods = false)
class GlobalInterceptorConfiguration {

    @GrpcGlobalServerInterceptor
    fun logServerInterceptor(): LogGrpcInterceptor? = LogGrpcInterceptor()
}