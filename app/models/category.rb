class Category < ApplicationRecord
  has_one_attached :image
  has_many :products, dependent: :destroy
  belongs_to :main_category, optional: true

  has_many :sub_categories, class_name: 'Category', foreign_key: :parent_id
  belongs_to :parent, class_name: 'Category', foreign_key: :parent_id, optional: true

  default_scope -> { order(created_at: :desc) }

  scope :parent_categories, -> { where(parent_id: nil)}

  def thumbnail
    return nil unless image.attached?
    image.variant(resize_to_limit: [150, 150]).processed
  end

  def medium
    return nil unless image.attached?
    image.variant(resize_to_limit: [300, 300]).processed
  end
end