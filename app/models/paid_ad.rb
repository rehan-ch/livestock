class PaidAd < ApplicationRecord
  belongs_to :user

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
