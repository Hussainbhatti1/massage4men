module Photoable
  extend ActiveSupport::Concern
  
  included do
    # Client and Masseur have the same routines for profile photo processing
    has_attached_file :profile_photo,
                       styles: {
                         medium: '300x300>',
                         thumb:  '250x250#',
                         medium_thumb: '100x100#',
                         small_thumb: '50x50#'
                       },
                       source_file_options: { all: '-auto-orient' },
                       convert_options: { all: '-quality 75 -strip' }

     validates_attachment_content_type :profile_photo, content_type: ALLOWED_PHOTO_FILETYPES
  end

  def has_profile_photo?
    profile_photo_file_name.present?
  end
end