package com.example.boardserver.delivery.grpc

import board.Session
import com.example.boardserver.entity.uuid
import com.example.boardserver.interceptor.ContextKeys
import com.example.boardserver.interceptor.LogGrpcInterceptor
import com.example.boardserver.repository.UserRepository
import io.grpc.Context
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.onCompletion
import net.devh.boot.grpc.server.service.GrpcService
import org.slf4j.LoggerFactory

@GrpcService(interceptors = [LogGrpcInterceptor::class])
class SessionServiceGrpc(
    private val userRepository: UserRepository
) : board.SessionAPIGrpcKt.SessionAPICoroutineImplBase() {

    override fun registerSession(requests: Flow<Session.EnterRequest>): Flow<Session.UserStatus> = run {
        val userId = ContextKeys.USER_ID_KEY.get(Context.current()).uuid()
        val user = userRepository.findById(userId).orElseThrow()
        flow {
            try {
                user.isOnline = true
                userRepository.save(user)
                requests.collect {
                    emit(Session.UserStatus.newBuilder().setId(user.id.toString()).setIsOnline(user.isOnline).build())
                }
                log.info("Register completed")
            } catch (e: Exception) {
                log.info("Error in RegisterSession: ${e.message}")
            }
        }.onCompletion {
            log.info("Unregister completed")
            user.isOnline = false
            userRepository.save(user)
        }
    }


    override fun subscribeUserSession(requests: Flow<Session.SubscribeRequest>): Flow<Session.UserStatus> = flow {
        try {
            requests.collect { request ->
                while (request.isSubscribe == true) {
                    val user = userRepository.findById(request.id.uuid()).orElseThrow()
                    emit(Session.UserStatus.newBuilder().setId(user.id.toString()).setIsOnline(user.isOnline).build())
                    delay(5000)
                }
            }
        } catch (e: Exception) {
            log.info("Error occurred: ${e.message}")
        } finally {
            log.info("Unsubscribe completed")
        }
    }

    companion object {
        private val log = LoggerFactory.getLogger(SessionServiceGrpc::class.java)
    }
}