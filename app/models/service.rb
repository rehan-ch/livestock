class Service < ApplicationRecord
  # attachments
  has_one_attached :cover_image

  # validations
  validates :title, :content, presence: true

  #enums
  enum status: %i[draft pending approved published archived]
end