class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :products, dependent: :destroy
  has_many :paid_ads, dependent: :destroy

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
end
