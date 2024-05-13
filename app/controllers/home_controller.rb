class HomeController < ApplicationController
    def index
        @categories = Category.all
        # update with popular scope
        @popular_products = Product.approved.page(page).per(10)
        @recent_products = Product.page(page).per(10)
    end
end
