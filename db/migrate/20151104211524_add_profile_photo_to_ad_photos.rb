class AddProfilePhotoToAdPhotos < ActiveRecord::Migration
  def change
    add_column :ad_photos, :profile_photo, :boolean
  end
end
