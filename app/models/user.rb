class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :products, dependent: :destroy
  has_many :paid_ads, dependent: :destroy
  has_many :bought_chats, class_name: 'Chat', foreign_key: 'buyer_id', dependent: :destroy
  has_many :sold_chats, class_name: 'Chat', foreign_key: 'seller_id', dependent: :destroy

  has_one_attached :avatar

  enum role: [
    :general,
    :admin
  ], _default: :general

  attr_writer :login

  def login
    @login || self.phone_no || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["phone_no = :value OR email = :value", { value: login }]).first
    else
      where(conditions.to_h).first
    end
  end

  def chats
    Chat.where("buyer_id = ? OR seller_id = ?", id, id)
  end

  def avatar_url
    if avatar.attached?
      Rails.application.routes.url_helpers.rails_blob_url(avatar, only_path: true)
    else
      # Default avatar URL
      ActionController::Base.helpers.asset_url('default_avatar.png')
    end
  end
end
