class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_#{params[:chat_id]}_user_#{current_user.id}_product_user_#{params[:product_user_id]}"
    stream_from "chat_#{params[:chat_id]}_user_#{params[:product_user_id]}_product_user_#{current_user.id}"
  end

  def unsubscribed
  end

  def speak(data)
    message = Message.create!(
      content: data['message'],
      chat_id: params[:chat_id],
      user_id: current_user.id
    )
    ActionCable.server.broadcast "chat_#{params[:chat_id]}_user_#{current_user.id}_product_user_#{message.chat.product.user.id}", render_message(message)
    ActionCable.server.broadcast "chat_#{params[:chat_id]}_user_#{message.chat.product.user.id}_product_user_#{current_user.id}", render_message(message)
  end

  private

  def render_message(message)
    ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
  end
end
