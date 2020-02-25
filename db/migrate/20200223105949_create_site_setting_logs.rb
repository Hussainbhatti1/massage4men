class CreateSiteSettingLogs < ActiveRecord::Migration
  def change
    create_table :site_setting_logs do |t|
      t.text :site_changes

      t.timestamps null: false
    end
  end
end
