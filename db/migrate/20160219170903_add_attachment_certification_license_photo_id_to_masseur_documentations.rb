class AddAttachmentCertificationLicensePhotoIdToMasseurDocumentations < ActiveRecord::Migration
  def self.up
    change_table :masseur_documentations do |t|
      t.attachment :certification
      t.attachment :license
      t.attachment :photo_id
    end
  end

  def self.down
    remove_attachment :masseur_documentations, :certification
    remove_attachment :masseur_documentations, :license
    remove_attachment :masseur_documentations, :photo_id
  end
end
