package com.example.kotlin_chat_app.presentation.auth.sign_up

data class SignUpState(
    val name: String = "",
    val email: String = "",
    val password: String = "",
    val action: SignUpAction? = null,
)

abstract class SignUpAction {}

class SignUpSuccess : SignUpAction()
