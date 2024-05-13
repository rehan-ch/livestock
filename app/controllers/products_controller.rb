class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show ]

  # GET /products or /products.json
  def index
    products = Product.approved
    @search = params[:q]
    @products = if @search.blank?
                products.page(page).per(20)
             else
                products.where('LOWER(name) LIKE :search', search: "%#{@search.downcase}%").page(page).per(per(20))
              end
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
