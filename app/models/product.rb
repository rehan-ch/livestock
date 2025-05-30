require "image_processing/mini_magick"

class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :chats, dependent: :destroy

  has_one_attached :primary_image
  has_many_attached :images

  default_scope -> { order(created_at: :desc) }

  delegate :name, to: :category, prefix: true
  delegate :name, to: :user, prefix: true

  validates :primary_image, presence: true
  validates :name, presence: true
  validates :price, presence: true
  validates :sex, presence: true
  validates :short_description, presence: true
  validates :city, presence: true
  validate :user_has_available_ads, on: :create

  before_destroy :refund_ad_credit, if: :should_refund_ad?

  scope :filter_by_status, ->(status) { where(status: status) if status.present? && status.downcase !="all"}

  scope :filter_by_query, ->(query) { where('LOWER(name) LIKE ?', "%#{query.downcase}%") if query.present? }

  scope :filter_by_category, ->(category_id) { where(category_id: category_id) if category_id.present? }

  scope :filter_by_city, ->(city) { where('LOWER(city) LIKE ?', "%#{city.downcase}%") if city.present? }

  scope :search_by_name, ->(name) {
      where('LOWER(name) LIKE ?', "%#{name.downcase}%") if name.present?
    }

  scope :top_cities, ->(limit = 15) {
    unscope(:order)
      .where.not(city: [nil, '', 'undefined'])
      .group("LOWER(city)")
      .order(Arel.sql("COUNT(*) DESC"))
      .limit(limit)
      .pluck(Arel.sql("LOWER(city)"), Arel.sql("COUNT(*)"))
  }

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
  ], _default: :pending
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

  after_create :notify_admin, :update_user_number_of_ads

  def watermarked_images
    images.map do |img|
      img.variant(resize_to_fit: [800, 800], gravity: "center", pointsize: "100", fill: "#0aad0a30",weight: "500", draw: "rotate -30 text 0,0 'Livestock.pk'").processed
    end
  end

  def self.max_price
    maximum(:price) || 100000
  end

  private

  def notify_admin
    AdminMailer.new_ad_notification(self).deliver_later
  end

  def update_user_number_of_ads
    user.update(number_of_ads: user.number_of_ads - 1) unless user.admin?
  end

  def user_has_available_ads
    return if user&.admin?
    return if user&.number_of_ads.to_i > 0

    errors.add(:base, "You don't have any ads available. Please purchase more ads to continue posting.")
  end

  def should_refund_ad?
    pending? && !user&.admin?
  end

  def refund_ad_credit
    user.increment!(:number_of_ads)
  end
end
