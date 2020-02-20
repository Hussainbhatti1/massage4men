class ChangeHeightColumnsInMasseurDetails < ActiveRecord::Migration
  def change
    rename_column :masseur_details, :height, :height_feet
    add_column :masseur_details, :height_inches, :integer, after: :height_feet
    add_column :masseur_details, :height_cm, :integer, after: :height_inches
    
    remove_column :masseur_details, :height_unit, :integer
  end
end
