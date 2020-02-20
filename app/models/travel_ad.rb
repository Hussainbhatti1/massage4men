class TravelAd < Ad
  # Subclass from Ad model since most of this is the same.
  # We do need to change the table name manually.
  self.table_name = 'travel_ads'
    
  # Associations
  # Inherited from Ad model.
  has_many :ad_photos, dependent: :destroy
  has_many :photos, through: :ad_photos
    
  # Validations
  # Inherits all validations from Ad model.
  # Additionally, make sure masseur has travel ads remaining
  validate :masseur_has_travel_ads_remaining, if: :new_record?
  
  # Also it's not much of a travel ad without a location and dates
  validates :city, :state, :start_date, :end_date, presence: true
  
  # Callbacks
  # Inherits all callbacks from Ad model.
  before_save :geocode_ad_location
  after_commit :notify_nearby_clients
  
  # Make it mappable
  # acts_as_mappable

  # Instance Methods
  def travel_ad?
    true
  end
  
  def location_string(include_country = false)
    str = city
    
    if state
      str += ", #{state}"
    end
    
    if include_country
      str += " #{country}"
    end
    
    str
  end
    
  # These would normally inherit from the Ad class,
  # but we need to override them here since the Ad versions
  # compute the location based on the Masseur's home base.
  def latitude
    lat
  end
  
  def longitude
    lng
  end

  private
  # Validation Methods
  def masseur_has_travel_ads_remaining
    if !masseur.can_create_travel_ad?
      errors.add(:base, 'Your account cannot create any more travel ads.')
    end
  end

  # Callback Methods
  def geocode_ad_location
    if city_changed? || state_changed? || country_changed?     
       geo = Geocoder.search(location_string)
       
       if geo.success?
         self.lat = geo.lat
         self.lng = geo.lng
       end       
     end
  end
  
  def notify_nearby_clients
    # Notify clients within 50 miles of the TravelAd's location
    SendTravelAdNotificationsJob.perform_later(self)
  end  
end
