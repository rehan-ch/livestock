class Admin::CategoriesController < Admin::BaseController
  before_action :set_category, only: %i[ show edit update destroy archive unarchive ]

  # GET /categories or /categories.json
  def index
    @categories = Category.all.page(page).per(per)
  end

  # GET /categories/1 or /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories or /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to admin_categories_path, notice: "category was successfully created." }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to admin_categories_path, notice: "category was successfully updated." }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.archive!
    @category.sub_categories.each do |sub_category|
      sub_category.archive!
    end

    respond_to do |format|
      format.html { redirect_to admin_categories_path, notice: "Category was successfully archived." }
      format.json { head :no_content }
    end
  end

  # POST /categories/1/archive
  def archive
    @category.archive!

    respond_to do |format|
      format.html { redirect_to admin_categories_path, notice: "Category was successfully archived." }
      format.json { head :no_content }
    end
  end

  # POST /categories/1/unarchive
  def unarchive
    @category.unarchive!

    respond_to do |format|
      format.html { redirect_to admin_categories_path, notice: "Category was successfully unarchived." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name, :description, :image, :parent_id, :main_category_id)
    end
end
