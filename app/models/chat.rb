class Chat < ApplicationRecord
	belongs_to :product
	belongs_to :buyer, class_name: 'User'
	belongs_to :seller, class_name: 'User'

	has_many :messages, dependent: :destroy

    validates :buyer_id, uniqueness: { scope: :product_id }
	validates :buyer, uniqueness: { scope: [:seller] }

	after_create_commit { broadcast_append_to "chats" }

	# Ensure that buyer and seller are not the same
	validate :buyer_and_seller_are_different

	def last_message
	  messages.order(created_at: :desc).first
	 end

	def other_user(current_user)
	  current_user == buyer ? seller : buyer
	end

	private

	def buyer_and_seller_are_different
		errors.add(:buyer, "can't be the same as seller") if buyer_id == seller_id
	end

end
