class AddAboutMeAndAboutMyServicesToAds < ActiveRecord::Migration
  def change
    add_column :ads, :about_me, :text
    add_column :ads, :about_my_services, :text
  end
end
