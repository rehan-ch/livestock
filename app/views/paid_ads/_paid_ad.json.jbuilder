json.extract! paid_ad, :id, :user_id, :quantity, :status, :created_at, :updated_at
json.url paid_ad_url(paid_ad, format: :json)
