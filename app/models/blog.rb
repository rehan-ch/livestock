class Blog < ApplicationRecord
  # attachments
  has_one_attached :cover_image
  has_one_attached :banner_image

  # validations
  validates :title, :short_description, :meta_title, :meta_description, :body, :meta_keywords, presence: true

  # callbacks
  before_save :set_published_at
  before_validation :generate_slug


  #enums
  enum status: %i[draft pending approved published archived]

  private

  def generate_slug
    self.slug = title.parameterize if title.present? && slug.blank?
  end

  def set_published_at
    self.published_at = Time.current if published? && published_at.nil?
  end
end