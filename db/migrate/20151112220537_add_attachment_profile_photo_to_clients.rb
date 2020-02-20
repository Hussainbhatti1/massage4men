class AddAttachmentProfilePhotoToClients < ActiveRecord::Migration
  def self.up
    change_table :clients do |t|
      t.attachment :profile_photo
    end
  end

  def self.down
    remove_attachment :clients, :profile_photo
  end
end
