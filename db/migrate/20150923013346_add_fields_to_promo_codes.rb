class AddFieldsToPromoCodes < ActiveRecord::Migration
  def change
    add_column :promo_codes, :basic_discount_percentage, :integer
    add_column :promo_codes, :premium_discount_percentage, :integer
    add_column :promo_codes, :length_in_days, :integer
  end
end
