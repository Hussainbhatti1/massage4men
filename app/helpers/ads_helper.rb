module AdsHelper
  def embedded_map_url(str)
    "https://www.google.com/maps/embed/v1/view?zoom=11&center=#{str}&key=#{GOOGLE_MAPS_API_KEY}"
  end
  
  def ad_url_for(masseur, ad_type)
    if ['Therapeutic', 'Relaxation', 'Customized'].include? ad_type
      if ad_type == 'Therapeutic'
        therapeutic_masseur_ads_path(masseur)
      elsif ad_type == 'Relaxation'
        relaxation_masseur_ads_path(masseur)
      elsif ad_type == 'Customized'
        customized_masseur_ads_path(masseur)
      end
    else
      root_url
    end
  end
  
  def friendly_ad_path(ad)
    # Returns the ad's path with a string for the MassageType
    if ad.travel_ad?
      masseur_travel_ad_path(ad.masseur, ad)
    else
      send("#{ad.massage_type.name.downcase}_masseur_ads_path", ad.masseur)      
    end
  end
  
  # Specialized paths for regular vs. travel ads
  def ad_edit_path(ad)
    if ad.travel_ad?
      edit_masseur_travel_ad_path(ad.masseur, ad)
    else
      edit_masseur_ad_path(ad.masseur, ad)
    end    
  end

  def ad_delete_path(ad)
    if ad.travel_ad?
      masseur_travel_ad_path(ad.masseur, ad)
    else
      masseur_ad_path(ad.masseur, ad)
    end
  end
  
  def answer_or_pnta(question)
    if question.present?
      question.name
    else
      'PNTA'
    end
  end

  
  def facebook_url_for(username)
    "https://facebook.com/#{username}"
  end
  
  def linkedin_url_for(username)
    "https://linkedin.com/in/#{username}"
  end
  
  def pinterest_url_for(username)
    "https://pinterest.com/#{username}"
  end
  
  def blur_if_necessary(photo)
    if photo.adult
      if current_user
        photo.picture.url(:thumb)
      else
        photo.picture.url(:blurred_thumb)
      end
    else
      photo.picture.url(:thumb)
    end
  end
  
  def fullsize_if_allowed(photo)
    if photo.adult
      if current_user
        photo.picture.url(:resized)
      else
        login_path
      end
    else
      photo.picture.url(:resized)
    end
  end
  
  def image_link_data(photo)
    if photo.adult && !current_user
      {toggle: 'modal', target: '.modal'}
    else
      {toggle: 'lightbox', type: 'image', parent: '.slider-responsive', gallery: 'user-gallery'}
    end
  end  
  
  def photo_or_placeholder(ad_photo, size = :thumb)
    if ad_photo
      ad_photo.photo.picture.url(size)
    else
      '/missing.png'
    end    
  end
    
  def weight_with_unit(masseur)
    "#{masseur.masseur_detail.weight} #{masseur.masseur_detail.weight_unit}"
  end
  
  def popover_text_with_disclaimer(popover_text)
    "#{popover_text}<p class=\"badge-disclaimer text-muted\">#{@settings.badge_disclaimer}</p>"
  end  
end
