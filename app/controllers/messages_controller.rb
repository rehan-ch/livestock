class MessagesController < ApplicationController
  before_action :set_chat
  before_action :set_message, only: %i[show edit]

  # GET /messages
  def index
    @messages = @chat.messages
  end

  # GET /messages/1
  def show;  end

  # GET /messages/new
  def new
    @message = @chat.messages.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages

  def create
    @chat = Chat.find_by_id(params[:chat_id])
    @message = @chat.messages.build(message_params)
    @message.user = current_user

    if @message.save
      broadcast_message(@message)
      head :ok
    else
     render 'chats/show'
    end
  end

  private
  def set_chat
    @chat = Chat.find(params[:chat_id])
  end

  def set_message
    @message = @chat.messages.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:content)
  end

  def render_message(message)
    ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
  end

  def broadcast_message(message)
    ActionCable.server.broadcast "chat_#{params[:chat_id]}_user_#{current_user.id}_product_user_#{message.chat.product.user.id}", render_message(message)
    ActionCable.server.broadcast "chat_#{params[:chat_id]}_user_#{message.chat.product.user.id}_product_user_#{current_user.id}", render_message(message)
  end
end
