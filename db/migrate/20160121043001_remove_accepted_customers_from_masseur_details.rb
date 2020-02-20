class RemoveAcceptedCustomersFromMasseurDetails < ActiveRecord::Migration
  def change
    remove_column :masseur_details, :accepted_customers, :string
  end
end
