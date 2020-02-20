class AddTravelAdReferenceToAdPhotos < ActiveRecord::Migration
  def change
    add_reference :ad_photos, :travel_ad, index: true, foreign_key: true
  end
end
