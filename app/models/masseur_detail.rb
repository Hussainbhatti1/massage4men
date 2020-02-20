class MasseurDetail < ActiveRecord::Base
  # acts_as_mappable   lat_column_name: :home_base_latitude,
                     # lng_column_name: :home_base_longitude
  
  geocoded_by :masseur_details_address, :latitude  => :home_base_latitude, :longitude => :home_base_longitude
  after_validation :geocode

  belongs_to :masseur
  
  belongs_to :build
  belongs_to :hair_color
  belongs_to :eye_color
  belongs_to :body_hair
  belongs_to :sexual_orientation
  belongs_to :smoking_frequency
  belongs_to :drug_frequency
  belongs_to :ethnicity
  
  has_and_belongs_to_many :services
  has_and_belongs_to_many :massage_techniques
  has_and_belongs_to_many :massage_products
  has_and_belongs_to_many :massage_types
  has_and_belongs_to_many :work_locations
  has_and_belongs_to_many :work_surfaces
  has_and_belongs_to_many :client_types
    
  has_many :rates
  
  has_many :masseur_languages, dependent: :destroy
  has_many :languages, through: :masseur_languages
  
  # Presence validations
  validates :home_base_city,
            :home_base_state,
            :home_base_zip,
            presence: true
  
  # Height validations
  validates :height_cm, inclusion: {
    in: 90..244,
    message: 'Nobody has ever been that tall!',
    allow_blank: true
  }
  
  validates :display_age, numericality: {   only_integer: true,
                                            greater_than_or_equal_to: 18,
                                            allow_nil: true}
  
  # If we are given imperial, convert it to metric and vice-versa.
  before_save :convert_height
  before_save :geocode_home_base
  
  def geocode_home_base
    # Hit the geocoder to update the lat/lng if any home base info has changed
    if self.home_base_city_changed? ||
       self.home_base_state_changed? ||
       self.home_base_zip_changed? ||
       self.home_base_country_changed?
       
       geo = Geocoder.search(self.home_base_string)
       if geo.present?
        geo = geo.first.coordinates

        self.home_base_latitude = geo[0]
        self.home_base_longitude = geo[1]
       end       
     end
  end
  
  def home_base_string(include_zip = true, include_country = true)
    str = ''
    
    if self.home_base_city
      str = self.home_base_city
    end
    
    if self.home_base_state
      str += ', ' + self.home_base_state
    end
    
    if self.home_base_zip && include_zip
      str += ' ' + self.home_base_zip
    end
    
    if self.home_base_country && include_country
      str += ' ' + self.home_base_country
    end
    
    str
  end
  
  # Height-related stuff
  def convert_height
    # If we're given imperial, convert to metric
    if self.height_feet && self.height_inches
      self.height_cm = height_in_centimeters
    elsif self.height_cm
      # Convert to inches first
      # "175 cm = 68.89 inches"
      total_inches = self.height_cm / 2.54
      self.height_feet = total_inches.div 12
      self.height_inches = (total_inches % 12).round
    else
      true
    end
  end
  
  def height_in_centimeters
    # Use height_cm if it exists
    if self.height_cm
      height_cm
    elsif self.height_feet && self.height_inches
      # Convert to inches and multiply by 2.54
      (((self.height_feet * 12) + self.height_inches) * 2.54).round
    else
      false
    end
  end
  
  def offers_incall?
    # FIXME: Another point of failure. This breaks if "Your place" changes
    self.work_locations.where(name: 'Your place').count > 0
  end
  
  # TODO: Return appropriate value based on completeness of object
  def complete?
    true
  end
  def masseur_details_address
    [home_base_city, home_base_state, home_base_zip].compact.join(', ')
  end
end
