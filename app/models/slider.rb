class Slider < ApplicationRecord
  validates :title, presence: true
  validates :position, presence: true, numericality: { only_integer: true }
  
  scope :active, -> { where(active: true) }
  scope :ordered, -> { order(position: :asc) }
  
  has_one_attached :image
end
