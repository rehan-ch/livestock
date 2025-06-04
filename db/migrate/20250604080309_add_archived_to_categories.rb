class AddArchivedToCategories < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :archived, :boolean, default: false
    add_index :categories, :archived
  end
end
