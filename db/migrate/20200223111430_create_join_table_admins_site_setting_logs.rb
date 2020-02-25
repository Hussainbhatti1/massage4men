class CreateJoinTableAdminsSiteSettingLogs < ActiveRecord::Migration
  def change
    create_join_table :site_setting_logs, :admins do |t|
      t.index [:site_setting_log_id, :admin_id], :name => "index_site_logs"
      t.index [:admin_id, :site_setting_log_id], :name => "index_admin_logs"
    end
  end
end
