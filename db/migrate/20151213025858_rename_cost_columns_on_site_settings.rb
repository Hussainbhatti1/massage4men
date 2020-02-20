class RenameCostColumnsOnSiteSettings < ActiveRecord::Migration
  def change
    rename_column :site_settings, :basic_package_cost, :basic_package_price
    rename_column :site_settings, :premium_package_cost, :premium_package_price
  end
end
