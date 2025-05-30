class AddNumberOfAdsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :number_of_ads, :integer, default: 5
  end
end
