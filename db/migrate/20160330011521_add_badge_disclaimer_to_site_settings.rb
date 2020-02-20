class AddBadgeDisclaimerToSiteSettings < ActiveRecord::Migration
  def change
    add_column :site_settings, :badge_disclaimer, :text
  end
end
