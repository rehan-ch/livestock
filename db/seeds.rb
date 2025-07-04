# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
["test", "test1", "test2", "test3"].each do |user_name|
    User.find_or_create_by(name: user_name, email: "#{user_name}@gmail.com") do |user|
        user.password = "12345678"
    end
end

MainCategory.create(name: "Livestock")
MainCategory.create(name: "Purpose-Based")

10.times do 
categories_params = {name: Faker::Commerce.product_name, description: Faker::Lorem.paragraph(sentence_count: 2)}
Category.create(categories_params)
end

100.times do
  params = {
    user_id: User.first&.id, 
    category_id: Category.all.pluck(:id).shuffle.first,
    product_type: nil,
    name: Faker::Commerce.product_name,
    short_description: Faker::Lorem.sentence(word_count: 5),
    long_description: Faker::Lorem.paragraph(sentence_count: 2),
    age: rand(0.5..30.0).round(2),
    quantity_unit: ["liter", "milliliter", "gram"].sample,
    sex: ["male", "female", "other"].sample,
    breed: Faker::Creature::Animal.name,
    height: Faker::Number.decimal(l_digits: 2),
    weight: Faker::Number.decimal(l_digits: 2),
    teeth: rand(20..32),
    castrated: Faker::Boolean.boolean,
    price: Faker::Commerce.price(range: 0..100.0),
    quantity: Faker::Number.between(from: 1, to: 1000),
    city: Faker::Address.city,
    country: Faker::Address.country,
    state: Faker::Address.state,
    address: Faker::Address.full_address,
    status: 'approved'
  }

  Product.create(params)
end

# Create social media links
SocialMediaLink.create!(
  platform: 'Facebook',
  url: 'https://www.facebook.com/LivestockPakistan?mibextid=ZbWKwL',
  icon_class: 'facebook',
  active: true
)

SocialMediaLink.create!(
  platform: 'TikTok',
  url: 'https://www.tiktok.com/@livestock.pk?_t=8n5KdeJFc8H&_r=1',
  icon_class: 'tiktok',
  active: true
)

SocialMediaLink.create!(
  platform: 'Instagram',
  url: 'https://www.instagram.com/livestock.pk?igsh=MWN1d2prazY4Zm11cQ==',
  icon_class: 'instagram',
  active: true
)
