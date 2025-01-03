class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :chats, dependent: :destroy

  has_one_attached :primary_image
  has_many_attached :images

  default_scope -> { order(created_at: :desc) }

  delegate :name, to: :category, prefix: true
  delegate :name, to: :user, prefix: true

  scope :filter_by_status, ->(status) { where(status: status) if status.present? && status.downcase !="all"}

  scope :filter_by_query, ->(query) { where('LOWER(name) LIKE ?', "%#{query.downcase}%") if query.present? }

  scope :filter_by_category, ->(category_id) { where(category_id: category_id) if category_id.present? }

  scope :filter_by_city, ->(city) { where('LOWER(city) LIKE ?', "%#{city.downcase}%") if city.present? }

  scope :filter_by_price, ->(min, max) {
    if min.present? && max.present?
      where('price >= ? AND price <= ?', min, max)
    elsif min.present?
      where('price >= ?', min)
    elsif max.present?
      where('price <= ?', max)
    end
  }

  scope :filter_by_self_stock, ->(self_stock) { where(self_stock: true) if self_stock == '1' }

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
