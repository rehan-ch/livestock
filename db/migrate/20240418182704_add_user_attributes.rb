class AddUserAttributes < ActiveRecord::Migration[7.1]
  def change
    change_table :users do |t|
        t.string :name
        t.string :phone_no
        t.string :farm_name
        t.string :province
        t.string :district
        t.string :tehsil 
        t.text :address
      end
  end
end
