json.extract! category, :id, :name, :description, :created_at, :updated_at
json.url users_category_url(category, format: :json)
