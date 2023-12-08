package com.example.kotlin_chat_app.domain.model

data class ChatSessionModel(
    val id: String? = null,
    val lastMessage: String? = null,
    val sentByUser: UserModel? = null,
)