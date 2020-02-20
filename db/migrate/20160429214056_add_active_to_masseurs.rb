class AddActiveToMasseurs < ActiveRecord::Migration
  def change
    add_column :masseurs, :active, :boolean, default: true
  end
end
