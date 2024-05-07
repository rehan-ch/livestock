class HomeController < ApplicationController
    def index
        @categories = Category.all
        # update with popular scope
        @popular_products = Product.approved.first(20)
    end
end
