class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_one_attached :primary_image
  has_many_attached :images

  default_scope -> { order(created_at: :desc) }

  delegate :name, to: :category, prefix: true
  delegate :name, to: :user, prefix: true

  scope :filter_by_status, -> (status){
    where(status: status) if status.present?
  }
  scope :filter_by_query, -> (query){
    where('LOWER(name) LIKE :search', search: "%#{query.downcase}%")
  }
  scope :filter_by_category, -> (category_id){
    where(category_id: category_id)
  }
  scope :filter_by_city, -> (city){
    where('LOWER(city) LIKE :search', search: "%#{city.downcase}%")
  }
  scope :filter_by_price, ->(min, max) {
  if min.present? && max.present?
    where('price > ? AND price < ?', min, max)
  elsif min.present?
    where('price > ?', min)
  elsif max.present?
    where('price < ?', max)
  end
}

  scope :filter_by_self_stock, -> (self_stock){
    where(self_stock: self_stock)
  }

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
