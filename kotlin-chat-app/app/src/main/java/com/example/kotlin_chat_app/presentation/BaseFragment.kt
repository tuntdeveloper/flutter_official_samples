package com.example.kotlin_chat_app.presentation

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.google.android.material.snackbar.Snackbar

abstract class BaseFragment : Fragment() {
    fun showShortSnackBar(message: String) {
        Snackbar.make(requireView(), message, Snackbar.LENGTH_SHORT).show()
    }

    fun showLongSnackBar(message: String) {
        Snackbar.make(requireView(), message, Snackbar.LENGTH_LONG).show()
    }

    fun replaceFragment(fragment: Fragment, frameLayout: Int) {
        val fragmentTransaction = activity?.supportFragmentManager?.beginTransaction();
        fragmentTransaction?.replace(frameLayout, fragment)?.addToBackStack("$frameLayout");
        fragmentTransaction?.commit();
    }

    fun onBackPressed() {
        val count: Int = requireActivity().supportFragmentManager.backStackEntryCount

        if (count == 0) {
            Log.d("TUNT", "POP")
            requireActivity().onBackPressedDispatcher.onBackPressed()
        } else {
            requireActivity().supportFragmentManager.popBackStack()
        }
    }

}
