class ChangeWeightUnitToString < ActiveRecord::Migration
  def up
    change_column :masseur_details, :weight_unit, :string
  end
  
  def down
    change_column :masseur_details, :weight_unit, :integer
  end
end
