package com.example.kotlin_chat_app.presentation.auth.sign_in

import android.graphics.Color
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.widget.addTextChangedListener
import com.example.kotlin_chat_app.R
import com.example.kotlin_chat_app.databinding.FragmentSignInBinding
import com.example.kotlin_chat_app.presentation.BaseFragment
import com.example.kotlin_chat_app.presentation.auth.sign_up.SignUpFragment

class SignInFragment : BaseFragment() {

    private lateinit var binding: FragmentSignInBinding
    private lateinit var viewModel: SignInViewModel

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentSignInBinding.inflate(layoutInflater)
        binding.signInToolBar.customToolBar.title = "Sign In"
        binding.signInEditTextEmail.customEditText.hint = "Please enter your email"
        binding.signInEditTextEmail.customLabel.text = "Email"
        binding.signInEditTextPassword.customEditText.hint = "Please enter your password"
        binding.signInEditTextPassword.customLabel.text = "Password"
        viewModel = SignInViewModel()
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        binding.signInEditTextPassword.customEditText.addTextChangedListener { text ->
            viewModel.validatePasswordStatus(text!!)
        }
        binding.loginButtonSignIn.setOnClickListener {
            if (viewModel.state.value?.allValid == true) {
                Log.d("TUNT", "All Valid")
                replaceFragment(
                    frameLayout = R.id.onboarding_frameLayout,
                    fragment = SignUpFragment()
                )
            }
        }
        viewModelObserver()
    }

    private fun viewModelObserver() {
        viewModel.state.observe(viewLifecycleOwner) { state ->
            binding.loginStatusPasswordLength.setTextColor(if (state.isValidLength) Color.GREEN else Color.RED)
            binding.loginStatusPasswordLowerCase.setTextColor(if (state.isValidLowerCase) Color.GREEN else Color.RED)
            binding.loginStatusPasswordUpperCase.setTextColor(if (state.isValidUpperCase) Color.GREEN else Color.RED)
            binding.loginStatusPasswordSpecial.setTextColor(if (state.isValidSpecial) Color.GREEN else Color.RED)
        }
    }
}