json.extract! product, :id, :user_id, :category_id, :ad_id, :status, :name, :short_description, :long_description, :age_in_years, :age_in_months, :sex, :breed, :height, :wight, :teeth, :castrated, :price, :quantity, :city, :countary, :state, :address, :self_stock, :verified, :created_at, :updated_at
json.url product_url(product, format: :json)
