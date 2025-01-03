class AddMainCategoryIdToCategories < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :main_category_id, :uuid
    add_index :categories, :main_category_id
  end
end
