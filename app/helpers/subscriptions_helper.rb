module SubscriptionsHelper
  def subscription_type_by_session
    (session[:m4m].present? && ['basic', 'premium'].include?(session[:m4m]['ad_type'])) ? session[:m4m]['ad_type'].titleize : 'Unknown'
  end
  
  def package_price_by_session
    if session[:m4m].blank? || session[:m4m]['ad_type'].blank?
      0
    else
      if session[:m4m]['ad_type'] == 'basic'
        @settings.basic_package_price
      elsif session[:m4m]['ad_type'] == 'premium'
        @settings.premium_package_price
      else
       0 
      end
    end
  end
end
