class AddNameToWorkLocations < ActiveRecord::Migration
  def change
    add_column :work_locations, :name, :string
  end
end
