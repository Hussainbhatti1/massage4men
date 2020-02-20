class MoveProvidesServicesColumnFromMasseurDetailsToMasseur < ActiveRecord::Migration
  def change
    remove_column :masseur_details, :provides_services_at_user_address
    add_column :masseurs, :provides_services_at_mailing_address, :boolean
  end
end
