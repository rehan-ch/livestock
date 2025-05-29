class HomeController < ApplicationController
    def index
        @categories = Category.where(parent: nil)
        # update with popular scope
        @popular_products = Product.approved.page(page).per(per)
        @recent_products = Product.approved.page(page).per(per)
        @published_services = Service.published.page(page).per(per)
        @blogs = Blog.published.order("RANDOM()").page.per(per(3))
    end

    def policy

    end

    def terms

    end
end
