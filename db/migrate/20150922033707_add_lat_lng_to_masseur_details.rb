class AddLatLngToMasseurDetails < ActiveRecord::Migration
  def change
    add_column :masseur_details, :home_base_latitude, :float
    add_column :masseur_details, :home_base_longitude, :float
  end
end
