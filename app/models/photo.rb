class Photo < ActiveRecord::Base
  belongs_to :masseur
  
  # Make sure we delete this photo from ads it's featured in when the photo is deleted.
  has_many :ad_photos, dependent: :destroy
  
  scope :unapproved, -> { where.not(approved: true) }
  scope :approved, -> { where(approved: true) }

  scope :sfw, -> { where(adult: false) }
  scope :nsfw, -> { where(adult: true) }

  before_create :set_unapproved

  # Paperclip processing for thumbs
  has_attached_file :picture,
                    styles: lambda { |picture| picture.instance.set_styles },
                    source_file_options: { all: '-auto-orient' },
                    convert_options: { all: '-quality 75 -strip' }

  validates_attachment_content_type :picture, content_type: ALLOWED_PHOTO_FILETYPES
  
  def set_styles
    styles = {
      original: {},
      resized: {
        geometry: 'x800>',
        format: :jpg,
        processors: [:watermark],
        watermark_path: "#{Rails.root}/public/m4m-watermark.png"
      },
      thumb: {
        format: :jpg,
        geometry: "250x250#" 
      },
      medium_thumb: {
        format: :jpg,
        geometry: "85x85#"
      },
      small_thumb: {
        format: :jpg,
        geometry: "50x50#"
      }
    }
    
    if self.adult
      styles[:blurred_thumb] = {
        geometry: '250x250#',
        format: :jpg,
        convert_options: "-blur 0x15"
      }      
    end
    
    styles
  end
  
  def set_unapproved
    self.approved = false
    
    # Again, setting that to false was ruining the callback chain
    true
  end
    
  def approve
    self.update_attributes(approved: true)
  end
  
  def approve_as_adult
    self.update_attributes(adult: true, approved: true)
  end
  
  def deny
    self.destroy
    
    # TODO: Let user know their photo was denied?
  end
end
