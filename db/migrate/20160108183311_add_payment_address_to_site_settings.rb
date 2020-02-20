class AddPaymentAddressToSiteSettings < ActiveRecord::Migration
  def change
    add_column :site_settings, :payment_address, :text
  end
end
