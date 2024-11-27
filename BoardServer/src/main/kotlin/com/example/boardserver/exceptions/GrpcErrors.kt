package com.example.boardserver.exceptions

import io.grpc.Status
import io.grpc.StatusException

sealed class GrpcErrors {
    class UserNotAuthorized : StatusException(Status.PERMISSION_DENIED)
    class NotFoundUser : StatusException(Status.NOT_FOUND.withDescription("User not found"))
    class NotVerified : StatusException(Status.NOT_FOUND.withDescription("User not verified"))
    class NotFoundAd : StatusException(Status.NOT_FOUND.withDescription("Ad not found"))
    class NotFoundComment : StatusException(Status.NOT_FOUND.withDescription("Comment not found"))
    class YouNotOwner : StatusException(Status.PERMISSION_DENIED.withDescription("You not owner"))
    class RepeatedPhoneNumber : StatusException(Status.ALREADY_EXISTS.withDescription("Repeated phone number"))
    class RepeatedUsername : StatusException(Status.ALREADY_EXISTS.withDescription("Repeated username"))
}

