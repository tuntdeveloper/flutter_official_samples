package com.example.kotlin_chat_app.presentation.auth.sign_up

import android.util.Log
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

class SignUpViewModel : ViewModel() {
    private var _state = MutableLiveData(SignUpState())
    val state: LiveData<SignUpState>
        get() = _state

    fun onChangeData(name: String? = "", email: String? = "", password: String? = "") {
        _state.value = _state.value?.copy(
            name = name ?: _state.value!!.name,
            email = email ?: _state.value!!.email,
            password = password ?: _state.value!!.password,
        )
    }

    fun onSignUp() {
        _state.value = _state.value?.copy(action = SignUpSuccess())
    }
}