class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_one_attached :primary_image
  has_many_attached :images

  enum status: [
    :draft,
    :pending,
    :rejected,
    :approved
  ]
  enum sex: [
    :male,
    :female,
    :other
  ]
  enum product_type: [
    :free,  
    :paid
  ]
end
