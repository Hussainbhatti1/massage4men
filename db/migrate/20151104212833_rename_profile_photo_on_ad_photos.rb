class RenameProfilePhotoOnAdPhotos < ActiveRecord::Migration
  def change
    rename_column :ad_photos, :profile_photo, :primary
  end
end
