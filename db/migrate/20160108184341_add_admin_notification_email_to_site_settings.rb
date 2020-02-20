class AddAdminNotificationEmailToSiteSettings < ActiveRecord::Migration
  def change
    add_column :site_settings, :admin_notification_email, :string
  end
end
