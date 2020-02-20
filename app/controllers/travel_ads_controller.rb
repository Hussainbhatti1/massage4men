class TravelAdsController < AdsController
  before_action :assign_instance_variable

  private
  def assign_instance_variable
    # load_and_authorize_resource from parent (AdsController) assigns instance variable to @travel_ad
    # We want it in @ad, so reassign it and nullify @travel_ad
    @ad = (@travel_ad ? @travel_ad : TravelAd.new)
    
    # Wipe out old @travel_ad
    @travel_ad = nil
  end
  
  def ad_params
    params.require(:travel_ad).permit( :massage_type_id,
                                :masseur_id,
                                :about_me,
                                :about_my_services,
                                :city,
                                :state,
                                :country,
                                :start_date,
                                :end_date,
                                :primary_photo,
                                :photo_ids => []
                              )
  end
  
  def travel_ad_params
    # When CREATING a travel ad, cancancan uses this method for sanitization...so let's alias it.
    ad_params
  end

end
