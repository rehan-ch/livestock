class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_one_attached :primary_image
  has_many_attached :images

  delegate :name, to: :category, prefix: true
  delegate :name, to: :user, prefix: true


  enum status: [
    :draft,
    :pending,
    :rejected,
    :approved
  ], _default: :draft
  #Ex:- :default =>''
  enum sex: [
    :male,
    :female,
    :other
  ]
  enum product_type: [
    :free,  
    :paid
  ]
  enum quantity_unit: {
    piece: 0,
    gram: 1,
    kilogram: 2,
    liter: 3,
    milliliter: 4
  }
end
