package com.example.kotlin_chat_app.data.firebase_firestore

import ResultQuery
import com.google.firebase.firestore.CollectionReference
import com.google.firebase.firestore.FirebaseFirestore
import com.google.firebase.firestore.local.QueryResult
import org.json.JSONObject
import java.lang.Exception

interface FirebaseFireStoreCoreBase<T> {
    suspend fun delete(): ResultQuery<Boolean>
    suspend fun create(data: Map<String, Any>): ResultQuery<Boolean>
    suspend fun update(): ResultQuery<Boolean>
    suspend fun get(filters: List<FilterData>): ResultQuery<T>?
    suspend fun getAll(filters: List<FilterData>): ResultQuery<MutableList<T>>
}

abstract class FirebaseFireStoreCore<T> constructor(
    private val pathCollection: String,

    ) :
    FirebaseFireStoreCoreBase<T> {

    abstract fun parseJson(json: String): T


    override suspend fun delete(): ResultQuery<Boolean> {
        TODO("Not yet implemented")
    }

    override suspend fun update(): ResultQuery<Boolean> {
        TODO("Not yet implemented")
    }


    override suspend fun create(data: Map<String, Any>): ResultQuery<Boolean> {
        return try {
            val result = FirebaseFirestore.getInstance().collection(pathCollection).add(data)

            if (result.isSuccessful) {
                ResultQuery.Success(true)
            } else {
                ResultQuery.Loading
            }
        } catch (e: Exception) {
            ResultQuery.Error(e)
        }
    }

    override suspend fun getAll(filters: List<FilterData>): ResultQuery<MutableList<T>> {
        try {
            var response = FirebaseFirestore.getInstance().collection(pathCollection)

            for (filter in filters) {
                response = response.whereEqualTo(
                    filter.field ?: "", filter.value
                ) as CollectionReference
            }

            val result = response.get().result.documents

            return if (result.isNotEmpty()) {
                val resultQuery: MutableList<T> =
                    result.map { parseJson(JSONObject(it.data).toString()) }.toMutableList()

                ResultQuery.Success<MutableList<T>>(resultQuery)
            } else {
                ResultQuery.Success(mutableListOf<T>())
            }
        } catch (e: Exception) {
            return ResultQuery.Error(e)
        }
    }

    override suspend fun get(filters: List<FilterData>): ResultQuery<T> {
        try {
            var response = FirebaseFirestore.getInstance().collection(pathCollection)

            for (filter in filters) {
                response = response.whereEqualTo(
                    filter.field ?: "", filter.value
                ) as CollectionReference
            }

            val result = response.get().result.documents.first().data

            return if (result != null) {
                val jsonObj = JSONObject(result)
                ResultQuery.Success(parseJson(jsonObj.toString()))
            } else {
                ResultQuery.Loading
            }
        } catch (e: Exception) {
            return ResultQuery.Error(e)
        }
    }
}

data class FilterData(
    val field: String? = null,
    val value: String? = null,
)