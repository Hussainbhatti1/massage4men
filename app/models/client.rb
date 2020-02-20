class Client < ActiveRecord::Base
  include Mailable, Phone, Unique, Photoable, PgSearch

  geocoded_by :client_address
  after_validation :geocode
  
  # Extensions
  devise  :database_authenticatable,
          :registerable,
          :recoverable,
          :rememberable,
          :trackable,
          :validatable
         
  # acts_as_mappable  lat_column_name: :latitude,
                    # lng_column_name: :longitude

  acts_as_messageable
  
  extend FriendlyId
  friendly_id :screen_name, use: [:slugged, :finders]

  pg_search_scope :full_text_search, (lambda do |args, query|
    return {
      against: args, query: query,
      using: {tsearch: {prefix: true}}
    }
  end)

  # Use this attribute for AJAX signups: it tells the model not to do additional validation
  attr_accessor :age_verified, :source

  # VALIDATIONS
  # Email is covered by Devise...it seems.
    
  # Validate other fields only when doing a full signup
  # validates :dob,
  #           :screen_name,
  #           :zip,
  #           :profile_photo,
  #           presence: true,
  #           if: 'age_verified.blank?'

  validate :email_must_not_be_in_use_by_client_or_masseur, if: :email_changed?
  validate :screen_name_must_not_be_in_use_by_client_or_masseur, if: :screen_name_changed?
  
  # validates :screen_name, uniqueness: true, if: 'age_verified.nil?'
  
  validates :age_verified, acceptance: { accept: '1', message: 'Please verify that you are at least 18.'}, if: 'age_verified.present?'

  # validates_date :dob,  before: lambda { 18.years.ago + 1.day },
  #                       before_message: 'All members MUST be at least 18 years old.',
  #                       if: 'age_verified.nil?'
                          
  # Associations
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_masseurs, through: :favorites, source: :masseur
  
  # ActiveRecord callbacks
  before_save :geocode_zip
  after_commit :send_welcome_email, :new_client_signup, on: :create
 
  def active_for_authentication?
    super and self.active?
  end

  def geocode_zip
    if self.zip_changed?       
       geo = Geocoder.search(self.zip)
  
       if geo.present?
        geo = geo.first.coordinates
         self.latitude = geo[0]
         self.longitude = geo[1]
       end       
     end    
  end
  
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  
  def display_name
    (self.screen_name.nil? || self.screen_name.empty?) ? self.first_name : self.screen_name
  end
  
  def age
    now = Time.now.utc.to_date
    (now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1))    
  end
  
  def profile_picture
    self.profile_photo
  end
  
  def send_welcome_email
    ClientMailer.welcome_message(self).deliver_later
  end
  
  def new_client_signup
    AdminMailer.new_client_signup(self).deliver_later
  end
  
  def favorited?(masseur)
    !self.favorites.find_by(masseur: masseur).nil?
  end
  
  def suspend
    self.update_attributes(active: false)    
  end
  
  def unsuspend
    self.update_attributes(active: true)
  end
  
  def mailboxer_email(object)
    email
  end
  
  # FriendlyID overrides
  def should_generate_new_friendly_id?
    true
  end
  
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
  
  # Setter overrides
  def phone=(phone)
    super(sanitize_phone_number(phone))
  end
  def client_address
    [city, state, zip].compact.join(', ')
  end

  def self.search(args, query)
    if query.join("").present?
      full_text_search(args, query)
    else
      order("created_at DESC")
    end
  end
end