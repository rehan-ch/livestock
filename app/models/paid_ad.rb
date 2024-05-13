class PaidAd < ApplicationRecord
  belongs_to :user

  default_scope -> { order(created_at: :desc) }

  enum status: [
    :draft,
    :pending,
    :rejected,
    :approved
  ]

  enum ad_type: [
    :general,
    :star,
    :verified
  ]

  enum payment_method: [
    :easypaisa,
    :jazzcash,
    :card
  ]
end
