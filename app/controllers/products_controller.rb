class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show start_chat]

  # GET /products or /products.json
  def index
    @products = Product.approved
                       .joins(:category)
                       .merge(Category.unarchived)
                       .filter_by_query(params[:q])
                       .filter_by_category(params[:category_id])
                       .filter_by_self_stock(params[:self_stock])
                       .filter_by_price(params[:start_price], params[:end_price])
                       .filter_by_city(params[:city])
                       .then { |products| apply_sorting(products) }
                       .page(params[:page])
                       .per(params[:per_page] || 20)
    @categories = Category.parent_categories.unarchived
  end

  # GET /products/1 or /products/1.json
  def show
    @product.increment_view_count
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

    def apply_sorting(products)
      case params[:sort]
      when 'price_asc'
        products.reorder(price: :asc)
      when 'price_desc'
        products.reorder(price: :desc)
      when 'created_at'
        products.reorder(created_at: :desc)
      else
        products.reorder(created_at: :desc)
      end
    end
end
