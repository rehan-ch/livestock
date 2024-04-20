class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category

  enum status: {
    :draft,
    :pending,
    :rejected,
    :approved
  }
  enum sex: {
    :male,
    :female,
    :other
  }
  enum product_type: {
    :free,  
    :paid
  }
end
