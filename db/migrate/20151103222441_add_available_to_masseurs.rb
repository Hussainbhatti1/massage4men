class AddAvailableToMasseurs < ActiveRecord::Migration
  def change
    add_column :masseurs, :available, :boolean
  end
end
