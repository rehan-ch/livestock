class MessagesController < ApplicationController
    before_action :set_chat
    before_action :set_message, only: [:show, :edit, :update, :destroy]
  
    # GET /messages
    def index
      @messages = @chat.messages
    end
  
    # GET /messages/1
    def show
    end
  
    # GET /messages/new
    def new
      @message = @chat.messages.new
    end
  
    # GET /messages/1/edit
    def edit
    end
  
    # POST /messages
    def create
      @message = @chat.messages.new(message_params)
      @message.user_id = current_user.id
  
      if @message.save
        redirect_to @chat, notice: 'Message was successfully created.'
      else
        render :new
      end
    end
  
    # Other actions...
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_chat
        @chat = Chat.find(params[:chat_id])
      end
  
      def set_message
        @message = @chat.messages.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def message_params
        params.require(:message).permit(:content)
      end
  end
  