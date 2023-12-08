package com.example.kotlin_chat_app.presentation.auth.sign_in

import android.text.Editable
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.launch
import javax.annotation.RegEx


class SignInViewModel : ViewModel() {

    private val _state = MutableLiveData(SignInState())
    val state: LiveData<SignInState>
        get() = _state

    fun validatePasswordStatus(password: Editable) {


        viewModelScope.launch {
            if (password.isEmpty()) {
                _state.postValue(
                    _state.value?.copy(
                        isValidLength = false,
                        isValidLowerCase = false,
                        isValidSpecial = false,
                        isValidUpperCase = false,
                    )
                )
            }

            val isValidLength = password.length >= 8
            val isValidLowerCase = password.contains(Regex("(?=.*[a-z])"))
            val isValidUpperCase = password.contains(Regex("(?=.*[A-Z])"))
            val isValidSpecial = password.contains(Regex("(?=.*\\W)"))

            _state.postValue(
                _state.value?.copy(
                    isValidLength = isValidLength,
                    isValidLowerCase = isValidLowerCase,
                    isValidUpperCase = isValidUpperCase,
                    isValidSpecial = isValidSpecial,
                    )
            )
        }
    }
}