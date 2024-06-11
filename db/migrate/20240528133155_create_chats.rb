class CreateChats < ActiveRecord::Migration[7.1]
  def change
    create_table :chats, id: :uuid do |t|
      t.references :seller, type: :uuid, null: false, foreign_key: {to_table: :users}
      t.references :buyer, type: :uuid, null: false, foreign_key: {to_table: :users}
      t.references :product, type: :uuid, null: false, foreign_key: true
      t.timestamps
    end
    add_index :chats, [:buyer_id, :seller_id, :product_id], unique: true
  end
end
