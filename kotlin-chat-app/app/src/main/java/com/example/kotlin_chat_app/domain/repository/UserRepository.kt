package com.example.kotlin_chat_app.domain.repository

import com.example.kotlin_chat_app.data.firebase_firestore.FirebaseFireStoreCore
import com.example.kotlin_chat_app.domain.model.UserModel
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.decodeFromJsonElement
import org.json.JSONObject
import javax.inject.Inject

class UserRepository constructor() : FirebaseFireStoreCore<UserModel>(
    pathCollection = "User"
) {
    override fun parseJson(json: String): UserModel {
        return Json.decodeFromString(json)
    }
}