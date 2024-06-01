class HomeController < ApplicationController
    def index
        @categories = Category.all
        # update with popular scope
        @popular_products = Product.approved.page(page).per(per)
        @recent_products = Product.page(page).per(per)
        @published_services = Service.published.page(page).per(per)
        @blogs = Blog.published.page.per(per(3))
    end
end
