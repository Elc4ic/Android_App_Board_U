package com.example.boardserver.config

import brave.Tracer
import brave.Tracing
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import zipkin2.reporter.brave.AsyncZipkinSpanHandler


@Configuration
class TracingConfig {

    @Bean
    fun tracing(zipkinSpanHandler: AsyncZipkinSpanHandler?): Tracing {
        return Tracing.newBuilder()
            .localIp("127.0.0.1")
            .localPort(9411)
            .localServiceName("Board Service")
            .build()
    }

    @Bean
    fun tracer(tracing: Tracing): Tracer {
        return tracing.tracer()
    }
}
