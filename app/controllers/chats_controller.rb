class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: %i[create]

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
    @chat = Chat.find_or_create_by(buyer: current_user, seller: @product.user, product: @product)
    @messages = @chat.messages

    respond_to do |format|
      format.js { render 'create' }
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def chat_params
    params.require(:chat).permit(:buyer_id, :seller_id, :product_id)
  end
end
