class ChatsController < ApplicationController
    before_action :authenticate_user!

    def def index
      @chats = current_user.all_chats
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
  