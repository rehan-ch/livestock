class AddQuantityUnitToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :quantity_unit, :integer
  end
end
