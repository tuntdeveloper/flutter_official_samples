package com.example.kotlin_chat_app.presentation.auth.sign_up

import android.os.Bundle
import android.text.InputType
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.lifecycle.viewModelScope
import com.example.kotlin_chat_app.R
import com.example.kotlin_chat_app.databinding.FragmentSignUpBinding
import com.example.kotlin_chat_app.presentation.BaseFragment
import com.example.kotlin_chat_app.presentation.auth.sign_in.SignInFragment

class SignUpFragment : BaseFragment() {
    private lateinit var binding: FragmentSignUpBinding
    private lateinit var viewModel: SignUpViewModel

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        viewModel = SignUpViewModel()
        binding = FragmentSignUpBinding.inflate(inflater)
        binding.signUpToolBar.customToolBar.title = "Sign Up"
        binding.signUpEditTextName.customEditText.hint = "Please enter your name"
        binding.signUpEditTextName.customLabel.text = "Name"
        binding.signUpEditTextEmail.customEditText.hint = "Please enter your email"
        binding.signUpEditTextEmail.customLabel.text = "Email"
        binding.signUpEditTextPassword.customEditText.hint = "Please enter your password"
        binding.signUpEditTextPassword.customLabel.text = "Password"
        binding.signUpEditTextPassword.customEditText.inputType = InputType.TYPE_CLASS_TEXT
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        binding.signUpToolBar.customToolBar.setNavigationOnClickListener {
            onBackPressed()
        }
        binding.signUPButtonSignUp.setOnClickListener {
            viewModel.onSignUp()
        }

        viewModel.state.observe(viewLifecycleOwner) { state ->

            if (state.action == SignUpSuccess()) {
                replaceFragment(
                    fragment = SignInFragment(),
                    frameLayout = R.id.onboarding_frameLayout
                )
            }
        }
    }
}