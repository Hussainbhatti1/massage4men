module Phone
  extend ActiveSupport::Concern
  
  def sanitize_phone_number(phone_number)
    phone_number.gsub(/\D/, '')
  end  
end