class Masseur < ActiveRecord::Base
  include ApplicationHelper, Mailable, Phone, Unique, Photoable, PgSearch

  geocoded_by :address
  after_validation :geocode
  # Extensions
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  extend FriendlyId
  friendly_id :screen_name, use: [:slugged, :finders]

  pg_search_scope :full_text_search, (lambda do |args, query|
    return {
      against: args, query: query,
      using: {tsearch: {prefix: true}}
    }
  end)

  # Associations
  belongs_to :tracking_link

  has_one :masseur_detail, dependent: :destroy

  has_many :ads, dependent: :destroy
  has_many :travel_ads, dependent: :destroy
  has_many :photos, dependent: :destroy

  has_many :reviews, dependent: :destroy

  has_many :subscriptions, dependent: :destroy
  has_many :subscription_transactions, through: :subscriptions

  has_one :trial, dependent: :destroy
  has_one :masseur_documentation, dependent: :destroy

  # geokit and mailboxer
  # acts_as_mappable through: :masseur_detail
  acts_as_messageable

  # REVISED VALIDATIONS
  validates :email,
            format: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/

  # validates :password,
  #           # format: { with: /(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[$@$!%*?&])/,
  #           #   message: 'must contain 1 uppercase, 1 lowercase and 1 special character' },
  #           confirmation: true

  validates :screen_name, :first_name, :last_name,
            presence: true

  validate :email_must_not_be_in_use_by_client_or_masseur, if: :email_changed?
  validate :screen_name_must_not_be_in_use_by_client_or_masseur, if: :screen_name_changed?

  # validates_date :dob,  before: lambda { 18.years.ago + 1.day },
  #                       before_message: 'All members MUST be at least 18 years old.'


  # validates :dob, :mailing_zip,
  #           presence: true

  # ActiveRecord callbacks
  before_create :set_approval
  after_create  :mark_tracking_link_as_converted, if: 'self.tracking_link'
  after_create  :create_dox_record,
                :create_detail_record,
                :notify_admin_for_approval,
                :schedule_initial_completion_reminder

  # Scopes
  #
  #default_scope {where(:is_deleted => false)}
  scope :blocked , -> { where(is_deleted: true) }
  scope :unapproved, -> { where.not(approved: true) }
  scope :approved, -> { where(approved: true) }

  # Pseudo-delegations
  def city
    masseur_detail.present? ? masseur_detail.home_base_city : '?'
  end

  def state
    masseur_detail.present? ? masseur_detail.home_base_state : '?'
  end

  def phone
    masseur_detail.present? ? masseur_detail.display_phone : '?'
  end

  # Other crap
  def ad_by_type(ad_type)
    self.ads.includes(:massage_type).find_by(massage_types: { name: ad_type })
  end

  def can_create_local_ad?
    sub = self.active_subscription

    if sub
      if sub.subscription_type == SUBSCRIPTION_BASIC
        self.ads.count < BASIC_LOCAL_AD_LIMIT
      elsif sub.subscription_type == SUBSCRIPTION_PREMIUM
        self.ads.count < PREMIUM_LOCAL_AD_LIMIT
      end
    else
      false
    end
  end

  def travel_ads_allowed
    sub = self.active_subscription

    if sub
      if sub.subscription_type == SUBSCRIPTION_BASIC
        BASIC_TRAVEL_AD_LIMIT
      elsif sub.subscription_type == SUBSCRIPTION_PREMIUM
        PREMIUM_TRAVEL_AD_LIMIT
      end
    else
      0
    end
  end

  def can_create_travel_ad?
    sub = self.active_subscription

    if sub
      if sub.subscription_type == SUBSCRIPTION_BASIC
        self.travel_ads.count < BASIC_TRAVEL_AD_LIMIT
      elsif sub.subscription_type == SUBSCRIPTION_PREMIUM
        self.travel_ads.count < PREMIUM_TRAVEL_AD_LIMIT
      end
    else
      false
    end
  end

  def local_and_travel_ads
    ads + travel_ads
  end

  def display_name
    # Aliased to screen_name; formerly a more complex method
    self.screen_name
  end

  def full_name
    if !self.first_name.blank? or self.last_name.blank?
      "#{self.first_name} #{self.last_name}"
    elsif self.screen_name
       self.screen_name
    end
  end

  def age
    now = Time.now.utc.to_date
    if now.present? && dob.present?
      real_age = (now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1))
      return real_age if masseur_detail.nil?

      if masseur_detail.display_real_age
        real_age
      else
        masseur_detail.display_age
      end
    else
      return ''
    end
  end

  def approve
    self.update_attributes(approved: true)
  end

  def deny
    self.update_attributes(approved: false)
  end

  def active_trial
    if trial && trial.active?
      trial
    else
      nil
    end
  end

  def has_had_trial?
    trial ? true : false
  end

  def active_paid_subscription
    self.subscriptions.find_by(active: true)
  end

  def active_subscription
    # Returns a subscription OR a trial
    self.active_paid_subscription || self.active_trial
  end

  def premium?
    subscription = active_subscription

    return false if subscription.nil?

    subscription.subscription_type == SUBSCRIPTION_PREMIUM
  end

  def full_mailing_address(with_unit = true)
    address = ''

    address += (self.mailing_address.present? ? self.mailing_address : '')

    if with_unit
      address += (self.mailing_unit.present? ? "\nUnit #{self.mailing_unit}" : '')
    end

    address += (self.mailing_city.present? ? "\n#{self.mailing_city}, " : '')
    address += (self.mailing_state.present? ? "#{self.mailing_state} " : '')
    address += (self.mailing_zip.present? ? "#{self.mailing_zip}" : '')
  end

  def profile_picture
    # Use the first SFW Ad PrimaryPhoto they have
    # If no ads, they look like a silhouette
    if self.ads.count > 0
      photo = ads.first.primary_photo
      photo ? photo.photo : false
    else
      false
    end
  end

  def review_average
    # Return the average of all of a masseur's reviews
    self.reviews.average(:rating).to_f.round(1)
  end

  # has_?
  def has_social_networks?
    # True if the masseur has at least one social network entered
    (masseur_detail.show_facebook || masseur_detail.show_website || masseur_detail.show_linkedin || masseur_detail.show_pinterest) ? true : false
  end

  def has_approved_ads?
    # Wrapper around approved_ads
    ads.count > 0
  end

  def has_active_subscription?
    active_subscription ? true : false
  end

  def has_active_trial?
    active_trial ? true : false
  end

  def has_ever_subscribed?
    subscriptions.count > 0
  end

  def all_dox_approved?
    self.masseur_documentation.certification_approved &&
    self.masseur_documentation.license_approved &&
    self.masseur_documentation.photo_id_approved
  end

  def all_dox_submitted?
    return false if self.masseur_documentation.nil?

    self.masseur_documentation.certification.exists? &&
    self.masseur_documentation.license.exists? &&
    self.masseur_documentation.photo_id.exists?
  end

  def certification_uploaded?
    return false if self.masseur_documentation.nil?

    self.masseur_documentation.certification.exists?
  end

  def license_uploaded?
    return false if self.masseur_documentation.nil?

    self.masseur_documentation.license.exists?
  end

  def photo_id_uploaded?
    return false if self.masseur_documentation.nil?

    self.masseur_documentation.photo_id.exists?
  end

  def certification_approved?
    self.masseur_documentation.nil? ? false : self.masseur_documentation.certification_approved
  end

  def license_approved?
    self.masseur_documentation.nil? ? false : self.masseur_documentation.license_approved
  end

  def photo_id_approved?
    self.masseur_documentation.nil? ? false : self.masseur_documentation.photo_id_approved
  end

  def completed_percentage
    # Calculate the completeness of this profile
    # Details in https://basecamp.com/1768245/projects/10780080/documents/10790651

    # 1.  If the model is valid, that's the first 10%
    completeness = (self.valid? ? 10 : 0)

    # 2.  If all of the optional fields are present, that gets up to 30%
    [first_name, last_name, screen_name,
     mailing_city, mailing_state, mailing_zip,
     contact_phone, contact_phone_type].each do |field|

       if field.present?
         completeness += 2.5
       end
     end

     # 3. If Masseur has a valid MasseurDetail object, he's up to 50%
     completeness += (masseur_detail.present? && masseur_detail.valid? ? 20 : 0)

     # 4. If Masseur has at least one photo, he's up to 75%
     completeness += (self.photos.length > 0 ? 25 : 0)

     # 5. If Masseur has at least one ad, he's complete!
     completeness += (self.ads.length > 0 ? 25 : 0)

     # Make sure we round
     completeness.to_i
  end

  def calculate_completeness
    # A replacement method for completed_percentage
    # Returns a hash with a completeness percentage and a list of what's left to be done.
    # For this, we require:
    # Completed basic details
    # Completed (valid) questionnaire (MasseurDetail)
    # At least one Photo
    # At least one Ad
    # At least one Rate
    completeness = {
      basic_details: false,
      ad_details: false,
      photos: false,
      ads: false,
      rates: false,
      percentage: 0
    }

    # 2.  If all of the optional fields are present, that gets up to 30%
    [first_name, last_name, mailing_city, mailing_state, mailing_zip,
     contact_phone, contact_phone_type].each do |field|

       if field.present?
         completeness[:percentage] += 2
       end
     end

     # Max so far: 14%
     if completeness[:percentage] == 14
       completeness[:basic_details] = true
     end

     # Has Masseur has filled out his MasseurDetails?
     if (masseur_detail.present? && masseur_detail.complete?)
       completeness[:ad_details] = true
       completeness[:percentage] += 26
     end

     # Does masseur have at least one photo?
     if photos.length > 0
       completeness[:percentage] += 20
       completeness[:photos] = true
     end

     if ads.length > 0
       completeness[:percentage] += 20
       completeness[:ads] = true
     end

     if masseur_detail.present? && (masseur_detail.rates.length > 0)
       completeness[:percentage] += 20
       completeness[:rates] = true
     end

     # Return the final completeness hash
     completeness
  end


  def complete?
    calculate_completeness[:percentage] == 100
  end

  # Callbacks
  # TODO: See if these can be made private
  # before_create
  def set_approval
    self.approved = !SiteSetting.first.approval_required_for_new_masseurs

    # This was interrupting the callback chain and returning false, preventing my users from saving!
    # http://makandracards.com/makandra/791-dealing-with-activerecord-recordnotsaved
    true
  end

  # after_create
  def mark_tracking_link_as_converted
    tracking_link.mark_as_converted if tracking_link
  end

  def create_dox_record
    self.create_masseur_documentation
  end

  def create_detail_record
    # Geocode the IP that the user used. `false` parameter returns an array instead of a string
    begin
      ip_info = ip_info(current_sign_in_ip, false)
    rescue
      ip_info = {
        'city': 'Unknown',
        'state': 'XX',
        'postal': '90210'
      }
    end
    self.create_masseur_detail(
      home_base_city: ip_info['city'].present? ? ip_info['city'] : 'Unknown',
      home_base_state: ip_info['region'].present? ? ip_info['region'] : 'XX',
      home_base_zip: ip_info['postal'].present? ? ip_info['postal'] : '00000'
    )
  end

  # after_create hooks
  def schedule_initial_completion_reminder
    SendCompletionReminderJob.set(wait: 1.day).perform_later(self)
    PostAdsReminderJob.set(wait: 1.day).perform_later(self)
  end

  def notify_admin_for_approval
    if !self.approved? && SiteSetting.first.approval_required_for_new_masseurs
      MasseurMailer.notify_admin_for_approval_email(self).deliver_later
    end
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
  def contact_phone=(phone)
    super(sanitize_phone_number(phone))
  end
  def address
    [mailing_city, mailing_state, mailing_zip].compact.join(', ')
  end

  def self.search(args, query)
    if query.join("").present?
      full_text_search(args, query)
    else
      order(created_at: :desc)
    end
  end
end
