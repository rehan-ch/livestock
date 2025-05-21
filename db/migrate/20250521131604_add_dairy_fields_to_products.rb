class AddDairyFieldsToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :pregnant, :boolean
    add_column :products, :daily_milk_quantity, :decimal
  end
end
