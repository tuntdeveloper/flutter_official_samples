package com.example.kotlin_chat_app.domain.model

import kotlinx.serialization.Serializable


@Serializable
data class UserModel(
    val name: String? = null,
    val email: String? = null,
    val password: String? = null,
)
