class AddAndRemoveColumnsFromAds < ActiveRecord::Migration
  def change
    add_reference :ads, :massage_type, index: true, foreign_key: true
    remove_column :ads, :type, :integer
  end
end
