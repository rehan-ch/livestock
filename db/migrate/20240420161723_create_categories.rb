class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories, id: :uuid do |t|
      t.string :name
      t.text :description
      t.uuid :parent_id

      t.timestamps
    end
  end
end
