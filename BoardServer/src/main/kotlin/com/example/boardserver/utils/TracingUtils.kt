package com.example.boardserver.utils

import brave.Tracer
import org.slf4j.Logger


inline fun <T, R> T.runWithTracing(tracer: Tracer, name: String, log: Logger? = null, block: T.() -> R): R {
    val span = tracer.startScopedSpan(name)
    try {
        return block().also { span.tag("response", it.toString()) }
    } catch (ex: Exception) {
        span.error(ex)
        throw ex
    } finally {
        span.finish()
    }
}