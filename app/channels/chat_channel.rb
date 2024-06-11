class ChatChannel < ApplicationCable::Channel
  def subscribed
    chat = Chat.find_by_id(params[:chat_id])
    stream_for chat
  end

  def unsubscribed
    stop_all_streams
  end
end
