class CreateSliders < ActiveRecord::Migration[7.1]
  def change
    create_table :sliders, id: :uuid do |t|
      t.string :title, null: false
      t.text :content
      t.string :button_text
      t.string :button_link
      t.integer :position, default: 0
      t.string :image
      t.boolean :active, default: true

      t.timestamps
    end

    add_index :sliders, :position
    add_index :sliders, :active
  end
end
