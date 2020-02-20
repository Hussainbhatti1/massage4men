class AddEmailFieldsToPromoCodes < ActiveRecord::Migration
  def change
    add_column :promo_codes, :seven_day_email_subject, :string
    add_column :promo_codes, :seven_day_email_content, :text
    add_column :promo_codes, :fourteen_day_email_subject, :string
    add_column :promo_codes, :fourteen_day_email_content, :text
  end
end
