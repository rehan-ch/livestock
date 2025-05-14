class ChangeAgeInYearsMonthsToAgeInProducts < ActiveRecord::Migration[7.1]
  def change
    remove_column :products, :age_in_years
    remove_column :products, :age_in_months
    add_column :products, :age, :decimal, precision: 5, scale: 2
  end
end
