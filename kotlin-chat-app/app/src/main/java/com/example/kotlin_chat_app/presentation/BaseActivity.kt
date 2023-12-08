package com.example.kotlin_chat_app.presentation

import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment

abstract class BaseActivity : AppCompatActivity() {
    fun addFragment(fragmentId: Int, fragment: Fragment) {
        supportFragmentManager.beginTransaction().add(fragmentId, fragment)
            .addToBackStack("$fragmentId").commit()
    }


}
