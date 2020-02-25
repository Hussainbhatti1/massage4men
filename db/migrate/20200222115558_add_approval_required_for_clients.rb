class AddApprovalRequiredForClients < ActiveRecord::Migration
  def change
    add_column :site_settings, :approval_required_for_new_clients, :boolean, default: true
    add_column :clients, :approved, :boolean, default: false
  end
end
