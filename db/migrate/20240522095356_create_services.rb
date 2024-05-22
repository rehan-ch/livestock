class CreateServices < ActiveRecord::Migration[7.1]
  def change
    create_table :services, id: :uuid do |t|
      t.string :title
      t.text :content
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
