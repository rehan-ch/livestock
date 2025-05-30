class PaidAd < ApplicationRecord
  belongs_to :user
  GENERAL_AD_PRICE = 100
  FEATURED_AD_PRICE = 200

  has_one_attached :proof_image

  default_scope -> { order(created_at: :desc) }

  enum status: [
    :pending,
    :rejected,
    :approved
  ]

  enum ad_type: [
    :general,
    :featured,
  ]

  enum payment_method: [
    :easypaisa,
    :jazzcash,
    :bank_transfer
  ]

  def total_amount
    price_per_ad * quantity.to_i
  end

  def price_per_ad
    featured? ? FEATURED_AD_PRICE : GENERAL_AD_PRICE
  end
end
