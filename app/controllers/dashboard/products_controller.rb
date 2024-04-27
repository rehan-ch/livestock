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

      if results.present? && (result = results.first)
        address = result.address
        state = result.state
        city = result.city
        country = result.country

        if result.data.present? && (address_data = result.data["address"])
          city = (address_data["district"] || address_data["subdistrict"])&.gsub(/\bDistrict\b/, "")&.strip || city
          state = address_data["state"] || state
        end

        address_data = { address: address, city: city, state: state, country: country }
        render json: address_data
      else
        render json: { error: "Address information not found" }, status: :not_found
      end
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
