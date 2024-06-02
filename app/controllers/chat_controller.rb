class ChatController < ApplicationController
    before_action :authenticate_user!

    def index
      @chats = current_user.chats.includes(:messages)
      @chat = @chats.first
      @messages = @chat&.messages&.order(:created_at)

    end

    def show
      @chat = Chat.find(params[:id])
      @messages = @chat.messages.order(:created_at)
    end

    def create
      @chat = Chat.new(chat_params)
      if @chat.save
        redirect_to @chat, notice: 'Chat was successfully created.'
      else
        redirect_back fallback_location: root_path, alert: 'Chat could not be created.'
      end
    end
  
    private
  
    def chat_params
      params.require(:chat).permit(:buyer_id, :seller_id, :product_id)
    end
  end
  