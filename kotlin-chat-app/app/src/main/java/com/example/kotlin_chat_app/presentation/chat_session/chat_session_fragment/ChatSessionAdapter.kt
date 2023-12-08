package com.example.kotlin_chat_app.presentation.chat_session.chat_session_fragment

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.RecyclerView
import com.example.kotlin_chat_app.domain.model.ChatSessionModel
import androidx.recyclerview.widget.ListAdapter
import com.example.kotlin_chat_app.databinding.FragmentChatSessionItemBinding

class ChatSessionAdapter(private val clickListener: ChatSessionOnClickListener) :
    ListAdapter<ChatSessionModel, ChatSessionAdapter.ViewHolder>(ChatSessionDiffCallback()) {
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        return ViewHolder.from(parent)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val weatherForecast = getItem(position)
        holder.bind(weatherForecast)
        holder.itemView.setOnClickListener {
            clickListener.onClick()
        }
    }

    class ViewHolder(private val binding: FragmentChatSessionItemBinding) :
        RecyclerView.ViewHolder(binding.root) {

        fun bind(data: ChatSessionModel) {
            binding.chatSessionData = data
            binding.executePendingBindings()
        }

        companion object {
            fun from(parent: ViewGroup): ViewHolder {
                val layoutInflater = LayoutInflater.from(parent.context)
                val binding = FragmentChatSessionItemBinding.inflate(layoutInflater, parent, false)
                return ViewHolder(binding)
            }
        }
    }

    class ChatSessionDiffCallback : DiffUtil.ItemCallback<ChatSessionModel>() {
        override fun areItemsTheSame(
            oldItem: ChatSessionModel,
            newItem: ChatSessionModel
        ): Boolean {
            return oldItem.id == newItem.id
        }

        override fun areContentsTheSame(
            oldItem: ChatSessionModel,
            newItem: ChatSessionModel
        ): Boolean {
            return oldItem == newItem
        }
    }
    interface ChatSessionOnClickListener {
        fun onClick() {}
    }

}

