module Users
  class ProductsController < Users::BaseController
    before_action :set_product, only: %i[ show edit update destroy ]

    def index
      @products = current_user.products
    end

    def show; end

    def new
      @product = current_user.products.new
    end

    def edit; end

    def create
      @product = current_user.products.new(product_params)

      if @product.save
        redirect_to users_product_path(@product), notice: "Product was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @product.update(product_params)
        redirect_to users_product_path(@product), notice: "Product was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @product.destroy!
      redirect_to users_products_path, notice: "Product was successfully destroyed."
    end

    private
      def set_product
        @product = current_user.products.find(params[:id])
      end

      def product_params
        params.require(:product).permit(:user_id, :category_id, :status, :name, :short_description, :long_description, :age_in_years, :age_in_months, :sex, :breed, :height, :wight, :teeth, :castrated, :price, :quantity, :city, :countary, :state, :address, :self_stock, :verified)
      end
  end
end
