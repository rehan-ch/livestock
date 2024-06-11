class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show start_chat]

  # GET /products or /products.json
  def index
    @products = Product.approved
                       .filter_by_query(params[:q])
                       .filter_by_category(params[:category_id])
                       .filter_by_self_stock(params[:self_stock])
                       .filter_by_price(params[:start_price], params[:end_price])
                       .filter_by_city(params[:city])
                       .page(params[:page])
                       .per(20)
    @categories = Category.all
  end

  # GET /products/1 or /products/1.json
  def show
   @related_products = @product.category.products.page(page).per(5)
  end

  def start_chat
    @chat = Chat.find_by(buyer: current_user, product: @product)
    unless @chat
      @chat = Chat.create!(buyer: current_user, seller: @product.user, product: @product)
    end
    redirect_to chats_path(@chat)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end
end
