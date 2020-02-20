class AddServiceDetailsToMasseurDetails < ActiveRecord::Migration
  def change
    add_column :masseur_details, :service_details, :text
  end
end
