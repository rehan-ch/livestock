class Chat < ApplicationRecord
	belongs_to :buyer, class_name: 'User'
	belongs_to :seller, class_name: 'User'
	belongs_to :product

	has_many :messages, dependent: :destroy

	validates :buyer, uniqueness: { scope: [:seller] }

	# Ensure that buyer and seller are not the same
	validate :buyer_and_seller_are_different

	private

	def buyer_and_seller_are_different
		errors.add(:buyer, "can't be the same as seller") if buyer_id == seller_id
	end
end
