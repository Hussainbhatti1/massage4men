class MasseurDocumentation < ActiveRecord::Base
  belongs_to :masseur
  
  has_attached_file :certification
  has_attached_file :license
  has_attached_file :photo_id
  
  validates_attachment :certification, :license, :photo_id,
                       content_type: { content_type: ALLOWED_MASSEUR_DOCUMENTATION_FILETYPES }
end
