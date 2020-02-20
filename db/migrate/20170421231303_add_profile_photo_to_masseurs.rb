class AddProfilePhotoToMasseurs < ActiveRecord::Migration
  def self.up
    change_table :masseurs do |t|
      t.attachment :profile_photo
    end
  end

  def self.down
    remove_attachment :masseurs, :profile_photo
  end
end
