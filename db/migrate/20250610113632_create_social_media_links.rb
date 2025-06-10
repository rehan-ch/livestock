class CreateSocialMediaLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :social_media_links, id: :uuid do |t|
      t.string :platform, null: false
      t.string :url, null: false
      t.string :icon_class, null: false
      t.boolean :active, default: true, null: false

      t.timestamps
    end
    
    add_index :social_media_links, :platform, unique: true
    add_index :social_media_links, :active
  end
end
