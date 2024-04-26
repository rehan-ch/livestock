module Dashboard
  class ProductsController < Dashboard::BaseController
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
        redirect_to dashboard_products_path, notice: "Product was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @product.update(product_params)
        redirect_to dashboard_products_path, notice: "Product was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @product.destroy!
      redirect_to dashboard_products_path, notice: "Product was successfully destroyed."
    end

    def get_address
      results = Geocoder.search([params[:lat], params[:long]])
      address = results.first.address
      city = results.first.city
      country = results.first.country
      address_data = { address: address, country: country, city: city } # Define your address data here
      render json: address_data
    end

    private
      def set_product
        @product = current_user.products.find(params[:id])
      end

      def product_params
        params.require(:product).permit(:user_id, :category_id, :status, :name, :short_description, :long_description, :age_in_years, :age_in_months, :sex, :breed, :height, :wight, :teeth, :castrated, :price, :quantity, :city, :countary, :state, :address, :self_stock, :verified, :quantity_unit)
      end
  end
end
