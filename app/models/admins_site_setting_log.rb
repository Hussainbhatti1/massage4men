class AdminsSiteSettingLog < ActiveRecord::Base
  belongs_to :admin
  belongs_to :site_setting_log
end