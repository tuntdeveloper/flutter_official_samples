package com.example.kotlin_chat_app.presentation.auth.sign_in

data class SignInState(
    val isValidLength: Boolean = false,
    val isValidUpperCase: Boolean = false,
    val isValidLowerCase: Boolean = false,
    val isValidSpecial: Boolean = false,
) {
     val allValid: Boolean
        get() = isValidLength && isValidSpecial && isValidUpperCase && isValidLowerCase
}
