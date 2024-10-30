package com.example.boardserver.utils


import io.opentelemetry.api.trace.Span
import io.opentelemetry.api.trace.Tracer


inline fun <T, R> T.runWithTracing(span: Span, block: T.() -> R): R {
    return try {
        block()
    } catch (ex: Exception) {
        span.setStatus(io.opentelemetry.api.trace.StatusCode.ERROR, ex.message ?: "Unknown error")
        span.end()
        throw ex
    } finally {
        span.end()
    }
}

inline fun <T, R> T.runWithTracing(tracer: Tracer, name: String, block: T.() -> R): R {
    val span = tracer.spanBuilder(name).startSpan()
    return try {
        block()
    } catch (ex: Exception) {
        span.setStatus(io.opentelemetry.api.trace.StatusCode.ERROR, ex.message ?: "Unknown error")
        span.end()
        throw ex
    } finally {
        span.end()
    }
}