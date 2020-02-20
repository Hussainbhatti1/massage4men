class AddPageFieldsToSiteSettings < ActiveRecord::Migration
  def change
    add_column :site_settings, :advertise_page, :integer
    add_column :site_settings, :privacy_page, :integer
    add_column :site_settings, :tos_page, :integer
  end
end
