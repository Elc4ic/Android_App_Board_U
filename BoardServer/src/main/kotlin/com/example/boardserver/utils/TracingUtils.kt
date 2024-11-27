package com.example.boardserver.utils

import brave.Tracer

inline fun <T, R> T.runWithTracing(tracer: Tracer, name: String, block: T.() -> R): R {
    val span = tracer.startScopedSpan(name)
    tracer.currentSpan().remoteServiceName("board-server")
    try {
        return block().also { span.tag("response", it.toString()) }
    } catch (ex: Exception) {
        span.error(ex)
        throw ex
    } finally {
        span.finish()
    }
}