module Admin
  class ProductsController < Admin::BaseController
    before_action :set_product, only: %i[ show edit update destroy ]

    def index
      @products = Product.all
      
      if params[:status].present?
        @products = @products.where(status: params[:status])
      end

      if params[:search].present?
        @products = @products.where("name ILIKE ?", "%#{params[:search]}%")
      end
      
      @products = @products.page(params[:page])

      respond_to do |format|
        format.html
        format.json do
          render json: {
            html: render_to_string(partial: 'product_rows', locals: { products: @products }, formats: [:html])
          }
        end
      end
    end

    def show; end

    def new
      @product = current_user.products.new
    end

    def edit; end

    def create
      @product = current_user.products.new(product_params)

      if @product.save
        redirect_to admin_products_path, notice: "Product was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @product.update(product_params.reject { |k| k["images"] })
        if product_params[:images].present?
          product_params[:images].each do |image|
            @product.images.attach(image)
          end
        end

        redirect_to admin_products_path, notice: "Product was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @product.destroy!
      redirect_to dashboard_products_path, notice: "Product was successfully destroyed."
    end

    def filtered_categories
      @categories = Category.find_by(id: params[:parent_category_id]).sub_categories
      render json: @categories.map { |c| [c.name, c.id] }
    end

    private
      def set_product
        @product = Product.find(params[:id])
      end

      def product_params
        params.require(:product).permit(:user_id, :category_id, :status, :name, :short_description, :long_description, :age, :sex, :breed, :height, :weight, :teeth, :castrated, :price, :quantity, :city, :country, :state, :address, :self_stock, :verified, :quantity_unit, :primary_image, :pregnant, :daily_milk_quantity, images: [])
      end
  end
end
