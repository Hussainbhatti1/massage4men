module TravelAdsHelper
  def travel_ad_summary(ad)
    "#{ad.location_string}\n#{ad.start_date.to_s(:short_without_time)} to #{ad.end_date.to_s(:short_without_time)}"    
  end
  
  def duration_string(ad)
    if ad.start_date.year == Date.today.year
      start = ad.start_date.to_s(:short_without_year)
    else
      # We need the year
      start = ad.start_date.to_s(:short_without_time)
    end

    if ad.end_date.year == Date.today.year
      ending = ad.end_date.to_s(:short_without_year)
    else
      # We need the year
      ending = ad.end_date.to_s(:short_without_time)
    end
    
    raw("#{start} to #{ending}")
  end
end
