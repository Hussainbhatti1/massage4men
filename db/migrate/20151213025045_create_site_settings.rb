class CreateSiteSettings < ActiveRecord::Migration
  def change
    create_table :site_settings do |t|
      t.float :basic_package_cost
      t.float :premium_package_cost

      t.timestamps null: false
    end
  end
end
