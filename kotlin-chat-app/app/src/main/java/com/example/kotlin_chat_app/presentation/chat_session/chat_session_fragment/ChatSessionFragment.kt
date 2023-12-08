package com.example.kotlin_chat_app.presentation.chat_session.chat_session_fragment


import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.kotlin_chat_app.databinding.FragmentChatSessionBinding
import com.example.kotlin_chat_app.domain.model.ChatSessionModel
import com.example.kotlin_chat_app.domain.model.UserModel
import com.example.kotlin_chat_app.presentation.chat_session.chat_session_fragment.ChatSessionAdapter
import com.example.kotlin_chat_app.presentation.chat_session.chat_session_fragment.ChatSessionAdapter.ChatSessionOnClickListener

class ChatSessionFragment : Fragment(), ChatSessionOnClickListener {
    private val adapter by lazy { ChatSessionAdapter(this) }

    private lateinit var binding: FragmentChatSessionBinding

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentChatSessionBinding.inflate(layoutInflater)
        binding.chatSessionRecyclerview.layoutManager = LinearLayoutManager(activity)
        binding.chatSessionRecyclerview.adapter = adapter
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {

        val listChatSession = listOf(
            ChatSessionModel(
                id = "1",
                lastMessage = "123123",
                sentByUser = UserModel(
                    name = "Tu"
                )
            ),
            ChatSessionModel(
                id = "2",
                lastMessage = "123123",
                sentByUser = UserModel(
                    name = "Tu"
                )
            ),
            ChatSessionModel(
                id = "3",
                lastMessage = "123123",
                sentByUser = UserModel(
                    name = "Tu"
                )
            ),
            ChatSessionModel(
                id = "4",
                lastMessage = "123123",
                sentByUser = UserModel(
                    name = "Tu"
                )
            ),
            ChatSessionModel(
                id = "5",
                lastMessage = "123123",
                sentByUser = UserModel(
                    name = "Tu"
                )
            ),
            ChatSessionModel(
                id = "6",
                lastMessage = "123123",
                sentByUser = UserModel(
                    name = "Tu"
                )
            ),
            ChatSessionModel(
                id = "7",
                lastMessage = "123123",
                sentByUser = UserModel(
                    name = "Tu"
                )
            ),
        )

        adapter.submitList(listChatSession)
    }
}