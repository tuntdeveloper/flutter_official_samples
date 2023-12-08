package com.example.kotlin_chat_app

import android.os.Bundle
import androidx.databinding.DataBindingUtil
import com.example.kotlin_chat_app.databinding.ActivityOnboardingBinding
import com.example.kotlin_chat_app.presentation.BaseActivity
import com.example.kotlin_chat_app.presentation.auth.sign_in.SignInFragment

class MainActivity : BaseActivity() {
    private lateinit var binding: ActivityOnboardingBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = DataBindingUtil.setContentView(this, R.layout.activity_onboarding)
        addFragment(R.id.onboarding_frameLayout, SignInFragment())
    }
}
