class RemoveProfilePhotoFromMasseurs < ActiveRecord::Migration
  def change
    remove_attachment :masseurs, :profile_photo
  end
end
