class Admin::BlogsController < Admin::BaseController
  before_action :set_blog, only: %i[show edit update destroy]

  def index
    @blogs = Blog.page.per(per)
  end

  def show; end

  def new
    @blog = Blog.new
  end

  def edit; end

  def create
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to admin_blogs_path, notice: "blog was successfully created." }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to admin_blogs_path, notice: "blog was successfully updated." }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: "blog was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_blog
    @blog = Blog.find_by(id: params[:id])
  end

  def blog_params
    params.require(:blog).permit(:title, :body, :status, :banner_image, :cover_image, :published_at, :tag_keywords, :short_description, :meta_title, :meta_keywords, :meta_description, :slug)
  end
end
