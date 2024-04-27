class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products, id: :uuid do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.references :category, type: :uuid, null: false, foreign_key: true
      t.integer :status
      t.integer :product_type
      t.string :name
      t.string :short_description
      t.text :long_description
      t.integer :age_in_years
      t.integer :age_in_months
      t.integer :quantity_unit
      t.integer :sex
      t.string :breed
      t.float :height
      t.float :wight
      t.integer :teeth
      t.boolean :castrated
      t.integer :price
      t.integer :quantity
      t.string :city
      t.string :country
      t.string :state
      t.string :address
      t.boolean :self_stock
      t.boolean :verified

      t.timestamps
    end
  end
end
