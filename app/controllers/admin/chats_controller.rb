class Admin::ChatsController < Admin::BaseController    
    def index
        @chats = Chat.left_joins(:messages).group('chats.id').order('MAX(messages.created_at) DESC')
        @chat = @chats.first
        @messages = @chat ? @chat.messages.order(created_at: :asc) : []
    end

    def show
        @chats = Chat.left_joins(:messages).group('chats.id').order('MAX(messages.created_at) DESC')
        @chat = Chat.find(params[:id])
        @messages = @chat ? @chat.messages.order(created_at: :asc) : []
        render "index"
      end
end
