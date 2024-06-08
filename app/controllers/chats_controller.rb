class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: %i[create]

  def index
    @chats = current_user.buyer_chats.or(current_user.seller_chats)
    @chat = @chats.first
    @messages = @chat ? @chat.messages.order(created_at: :asc) : []
  end

  def create
    @chat = Chat.find_or_create_by(buyer: current_user, seller: @product.user, product: @product)
    @messages = @chat.messages

    respond_to do |format|
      format.js { redirect_to @chat }
    end
  end

  private

  def set_product
    @product = Product.find_by_id(params[:product_id])
  end

  def chat_params
    params.require(:chat).permit(:buyer_id, :seller_id, :product_id)
  end
end
