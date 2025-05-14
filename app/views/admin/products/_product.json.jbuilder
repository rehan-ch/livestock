json.extract! product, :id, :user_id, :category_id, :ad_id, :status, :name, :short_description, :long_description, :age, :sex, :breed, :height, :weight, :teeth, :castrated, :price, :quantity, :city, :country, :state, :address, :self_stock, :verified, :created_at, :updated_at
json.url product_url(product, format: :json)
