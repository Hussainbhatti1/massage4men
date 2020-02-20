class Subscription < ActiveRecord::Base
  belongs_to :masseur
  belongs_to :promo_code
  
  has_many :subscription_transactions, dependent: :destroy
  
  validates :subscription_type, presence: true,
                                inclusion: {in: [ SUBSCRIPTION_BASIC,
                                                  SUBSCRIPTION_PREMIUM]}

  def last_transaction
    if self.subscription_transactions
      self.subscription_transactions.order(created_at: :desc).first
    else
      nil
    end
  end
  
  def last_renewal
    if self.subscription_transactions.count > 1
      self.last_transaction
    else
      false
    end
  end

  def promo_amount
    # Load pricing packages
    prefs = load_packages
    
    # Compute the promotional amount
    if self.promo_code && self.promo_code.active
      if self.subscription_type == SUBSCRIPTION_BASIC
        prefs.basic_package_price.minus_percentage_discount(self.promo_code.basic_discount_percentage)
      elsif self.subscription_type == SUBSCRIPTION_PREMIUM
        prefs.premium_package_price.minus_percentage_discount(self.promo_code.premium_discount_percentage)        
      else
        # It should crash and burn when there's no subscription_type: This should never happen anyway!
        raise 'Attempted to compute promotional amount on a Subscription without a subscription_type'
      end
    else
      # If there's no promo code, return the full amount
      self.full_amount
    end
  end
  
  def promo_amount_in_cents
    # Should always return a whole number
    (self.promo_amount * 100).to_i
  end
  
  def full_amount
    prefs = load_packages
    
    if self.subscription_type == SUBSCRIPTION_BASIC
      prefs.basic_package_price
    elsif self.subscription_type == SUBSCRIPTION_PREMIUM
      prefs.premium_package_price
    else
      raise 'Attempted to compute full amount on a Subscription without a subscription_type'
    end
  end
  
  def full_amount_in_cents
    (self.full_amount * 100).to_i
  end
    
  def create_recurring_subscription(cc)
    # Perform complete transaction to create a recurring subscription:
    # 1. Initialize the gateway
    # 2. Run the transaction (with trial parameters if necessary)
    # 3. If transaction is successful, log it in a SubscriptionTransaction object associated with this Subscription and return true
    # 4. If transaction fails, return false
    gateway ||= get_gateway
    
    transaction = gateway.recurring(self.full_amount_in_cents, cc, generate_payment_options_hash(cc))

    if transaction.success?
      # Activate this subscription
      self.active = true
      
      # Save the subscription ID (so we can deactivate it if it lapses)
      self.gateway_subscription_id = transaction.params['subscription_id']
      
      # Save!
      self.save

      # Create a SubscriptionTransaction object
      # self.promo_amount always errs on the side of caution and returns full amount if no promo code!
      self.subscription_transactions.create(amount_charged: self.promo_amount,
                                            success: transaction.success?,
                                            cc_last_four: cc.last_digits,
                                            card_brand: cc.brand,
                                            serialized_response: transaction.to_json)
    end
    
    {success: transaction.success?, message: transaction.params['text']}.to_obj
  end
  
  private
  def get_gateway
    ActiveMerchant::Billing::AuthorizeNetArbGateway.new(login: AUTHORIZE_NET_LOGIN, password: AUTHORIZE_NET_KEY, test: AUTHORIZE_NET_USE_TEST_MODE)
  end
  
  def generate_payment_options_hash(cc)
    # Generates a hash in this format:
    # interval: {length: DAYS, unit: :days},
    # duration: {start_date: Date.today, occurrences: INFINITE_SUBSCRIPTION_OCCURRENCES (=9999)},
    # trial: {occurrences: trial_length_in_days, amount: trial_billed_amount} IF PROMO CODE,
    # billing_address: {first_name: cc.first_name, last_name: cc.last_name}
    
    options = {
      interval: {length: BILLING_INTERVAL, unit: :days},
      duration: {start_date: Date.today, occurrences: INFINITE_SUBSCRIPTION_OCCURRENCES},
      billing_address: {first_name: cc.first_name, last_name: cc.last_name}
    }
    
    if self.promo_code
      # Occurrences: Length in days / BILLING_INTERVAL
      options[:trial] = {occurrences: (self.promo_code.length_in_days / BILLING_INTERVAL), amount: self.promo_amount_in_cents}
    end
    
    options    
  end
  
  def load_packages
    prefs = SiteSetting.first
    
    if !prefs
      raise 'Could not find price setting.'
    elsif !prefs.basic_package_price || !prefs.premium_package_price
      raise 'Package prices not set.'
    end
    
    prefs    
  end
end
