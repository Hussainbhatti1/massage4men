class SiteSettingLog < ActiveRecord::Base
  serialize :site_changes
  has_and_belongs_to_many :admins
end
