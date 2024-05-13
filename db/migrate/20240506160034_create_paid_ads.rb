class CreatePaidAds < ActiveRecord::Migration[7.1]
  def change
    create_table :paid_ads, id: :uuid do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.integer :quantity
      t.integer :status, default: 0
      t.integer :payment_method
      t.integer :ad_type, default: 0
      t.timestamps
    end
  end
end
