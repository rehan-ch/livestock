class Category < ApplicationRecord
  has_one_attached :image
  has_many :products, dependent: :destroy

  has_many :sub_categories, class_name: 'Category', foreign_key: :parent_id
  belongs_to :parent, class_name: 'Category', foreign_key: :parent_id, optional: true

  scope :parent_categories, -> { where(parent_id: nil)}
end