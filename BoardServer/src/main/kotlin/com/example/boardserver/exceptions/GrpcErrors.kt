package com.example.boardserver.exceptions

class UserException(s: String) : RuntimeException("User error: $s")

class NotFoundException(s: String?) : RuntimeException("Не найден: $s")

class YouNotOwnerException : RuntimeException("Вы не владеёте объектом")