class AddApprovalRequiredForNewMasseursToSitePreferences < ActiveRecord::Migration
  def change
    add_column :site_settings, :approval_required_for_new_masseurs, :boolean, default: true
  end
end
