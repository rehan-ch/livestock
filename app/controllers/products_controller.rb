class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show ]

  # GET /products or /products.json
  def index
    @products = Product.approved
    @products = @products.filter_by_query(params[:q]) if params[:q].present?
    @products = @products.filter_by_category(params[:category_id]) if params[:category_id].present?
    @products = @products.filter_by_self_stock(params[:self_stock]) if params[:self_stock] == '1'
    @products = @products.filter_by_price(params[:start_price], params[:end_price]) if params[:start_price].present? || params[:end_price].present?
    @products = @products.filter_by_city(params[:city]) if params[:city].present?
    @products =  @products.page(page).per(per(20))
    @categories = Category.all
  end

  # GET /products/1 or /products/1.json
  def show
   @related_products = @product.category.products.page(page).per(5)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end
end
