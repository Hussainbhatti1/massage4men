class AddStartAndEndDatesToTravelAds < ActiveRecord::Migration
  def change
    add_column :travel_ads, :start_date, :date
    add_column :travel_ads, :end_date, :date
  end
end
