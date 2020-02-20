class AddDefaultsToMasseurs < ActiveRecord::Migration
  def change
    change_column :masseurs, :approved, :boolean, default: false
    change_column :masseurs, :featured, :boolean, default: false
    change_column :masseurs, :available, :boolean, default: false
  end
end
