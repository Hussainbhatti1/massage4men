class SiteSetting < ActiveRecord::Base
  # Validations
  validates :basic_package_price,
            :premium_package_price,
            :badge_disclaimer,
            :admin_notification_email,
            presence: true

  validates :basic_package_price,
            :premium_package_price,
            numericality: true
end
