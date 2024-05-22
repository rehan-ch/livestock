class Service < ApplicationRecord
  has_one_attached :cover_image

  validates :title, :content, presence: true

  #enums
  enum status: %i[drafts pending approved published inactive]
end