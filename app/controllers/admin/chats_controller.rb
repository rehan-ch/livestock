class Admin::ChatsController < Admin::BaseController
  def index
    @chats = Chat.includes(:seller, :buyer, :product)
                 .order(updated_at: :desc)
                 .page(params[:page])
  end

  def show
    @chat = Chat.includes(:messages, :seller, :buyer, :product).find(params[:id])
    @messages = @chat.messages.order(created_at: :asc)
  end
end 