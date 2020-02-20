class Ad < ActiveRecord::Base
  # Associations
  belongs_to :masseur
  belongs_to :massage_type
  
  has_many :ad_photos, dependent: :destroy
  has_many :photos, through: :ad_photos
  
  has_one :masseur_detail, through: :masseur
  
  # Callbacks
  after_create :notify_nearby_clients

  # Validations
  validates :masseur, :massage_type, presence: true
  
  # TODO: Implement this in TravelAd model as well.
  # It's already in there as :masseur_has_travel_ads_remaining
  # Use the same name in both so we can override it.
  validate :masseur_does_not_exceed_allowed_number_of_ads
  
  # Log impressions
  is_impressionable
    
  # Instance Methods
  def travel_ad?
    false
  end
  
  def distance_to(point)
    self.masseur_detail.distance_to(point)
  end  
    
  def primary_photo
    self.ad_photos.find_by(primary: true)
  end
  
  def masseur_does_not_exceed_allowed_number_of_ads
    # TODO: Implement this.
  end
  
  def notify_nearby_clients
    SendAdNotificationsJob.perform_later(self)
  end
  
  def latitude
    self.masseur.masseur_detail.home_base_latitude
  end
  
  def longitude
    self.masseur.masseur_detail.home_base_longitude
  end
  
  # Shortcuts to masseur attributes
  def masseur_name
    self.masseur.screen_name.present? ? self.masseur.screen_name : self.masseur.first_name 
  end
  
  def masseur_age
    self.masseur.masseur_detail.display_real_age ? self.masseur.age : self.masseur.masseur_detail.display_age
  end
end
