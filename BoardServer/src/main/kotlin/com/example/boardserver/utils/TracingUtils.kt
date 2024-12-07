package com.example.boardserver.utils

import brave.ScopedSpan
import brave.Tracer

inline fun <T, R> T.runWithTracing(span: ScopedSpan, block: T.() -> R): R {
    return try {
        block()
    } catch (ex: Exception) {
        span.error(ex)
        throw ex
    } finally {
        span.finish()
    }
}


inline fun <T, R> T.runWithTracing(tracer: Tracer, name: String, block: T.() -> R): R {
    val span = tracer.startScopedSpan(name)
    try {
        return block()
    } catch (ex: Exception) {
        span.error(ex)
        throw ex
    } finally {
        span.finish()
    }
}