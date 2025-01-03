class MainCategory < ApplicationRecord
  has_many :categories, dependent: :destroy
end
