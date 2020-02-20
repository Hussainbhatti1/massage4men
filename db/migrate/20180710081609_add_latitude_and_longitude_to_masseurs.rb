class AddLatitudeAndLongitudeToMasseurs < ActiveRecord::Migration
  def change
  	add_column :masseurs, :latitude, :float
  	add_column :masseurs, :longitude, :float
  end
end
