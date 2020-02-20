class TrackingLink < ActiveRecord::Base
  is_impressionable
  
  # Scopes
  scope :converted, -> { where(converted: true) }
  scope :unconverted, -> { where(converted: false) }
  
  # Validations
  before_validation :generate_code, if: 'code.blank?'
  validates :code, uniqueness: true
  
  # Associations
  has_one :masseur
  belongs_to :promo_code
  
  def mark_as_converted
    self.update_attributes(converted: true, converted_at: Time.now)
  end
  
  def usable?
    # Link is usable if it's not converted
    !converted
  end
  
  private
  def generate_code
    # Generate a 4-character code
    code = SecureRandom.hex(2)
    
    if TrackingLink.exists?(code: code)
      # Try again!
      generate_code
    else
      self.code = SecureRandom.hex(2)
    end
  end  
end
