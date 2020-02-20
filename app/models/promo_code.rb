class PromoCode < ActiveRecord::Base
  validates :code,
            :basic_discount_percentage,
            :premium_discount_percentage,
            :length_in_days,
            presence: true
    
  validates :basic_discount_percentage,
            :premium_discount_percentage,
            numericality: { only_integer: true,
                            greater_than_or_equal_to: 0,
                            less_than_or_equal_to: 100}

  validates :code, uniqueness: true

  before_save :set_start_date, if: 'start_date.nil?'

  has_many :promo_codes
  
  attr_accessor :subscription_type

  def set_start_date
    self.start_date = Time.now
  end
  
  def expired?
    self.end_date.nil? ? false : Time.now > self.end_date
  end
  
  def usable?
    !self.expired? && self.active
  end
  
  def requires_payment?(subscription_type)
    if subscription_type == SUBSCRIPTION_BASIC
      self.basic_discount_percentage < 100
    elsif subscription_type == SUBSCRIPTION_PREMIUM
      self.premium_discount_percentage < 100
    end
  end

  def deactivate
    self.update_attributes(active: false)
  end
  
  def activate
    self.update_attributes(active: true)
  end
end
