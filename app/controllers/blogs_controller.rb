class BlogsController < ApplicationController
  before_action :set_blog, only: %i[ show ]

  def index
    @blogs = Blog.published.page.per(per)
  end

  def show;  end

  private
    def set_blog
      @blog = Blog.published.find_by(slug: params[:id])
    end
end
