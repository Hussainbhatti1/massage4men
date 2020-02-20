class ActiveMerchant::Billing::CreditCard
  attr_accessor :expiry_string
  
  def initialize(attributes = {})
    # Add all attributes first
    super

    # If there's an expiry string, split it into MM/YY
    if @expiry_string
      assign_month_and_year
    end    
  end
  
  def expiry_string=(str)
    @expiry_string = str
    assign_month_and_year
  end
  
  def month=(month)
    @month = month
    update_expiry_string
  end
  
  def year=(year)
    @year = year
    update_expiry_string
  end

  def errors
    # Add the month/year errors to the expiry_string attribute as well
    super

    if @errors['month'].present?
      @errors['expiry_string'] << @errors['month'].join(',')
    end
    
    if @errors['year'].present?
      @errors['expiry_string'] << @errors['year'].join(',')
    end
    
    @errors
  end

  private
    def assign_month_and_year
      split_expiry = @expiry_string.split('/')
      
      @month = split_expiry.first.to_i
      
      year = split_expiry.last.to_i
      
      @year = pad_year(year)
      
      # Make sure expiry_string is formatted as Int/Int
      update_expiry_string      
    end
    
    def update_expiry_string
      if @month && @year
        @expiry_string = "#{@month}/#{pad_year(@year)}"
      end
    end
    
    def pad_year(year)
      year.to_s.length == 4 ? year : "20#{year}".to_i
    end
end