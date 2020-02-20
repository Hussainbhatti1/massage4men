module MasseursHelper
  def profile_photo_url_for(user, size = :thumb)
    if user.nil?
      '/images/missing.png'
    elsif user.kind_of? Client
      user.profile_photo.url(size)
    else
      (user.has_profile_photo? ? user.profile_photo : user.photos.sfw.sample.picture).url(size)      
    end    
  end
  
  def availability_times
    times = {}
    
    1.upto(BASIC_AVAILABILITY_LIMIT) do |hour|
      times["#{pluralize(hour, 'hour')}"] = hour
    end
      
    if @masseur.premium?
      times['12 Hours'] = 12
      times['24 Hours'] = 24
    end
      
    times
  end
  
  def sort_path(field)
    if params[:order]
      if params[:order] == 'asc'
        order = 'desc'
      else
        order = 'asc'
      end
    else
      order = 'desc'
    end
    
    "?sort=#{field}&order=#{order}"
  end
  
  def approval_label
    if @masseur.approved?
      '<span class="label label-success">Approved</span>'
    else
      '<span class="label label-warning">Unapproved</span>'
    end
  end
  
  def featured_label
    if @masseur.featured?
      '<span class="label label-info">Featured</span>'
    end
  end
  
  def suspended_label
    if !@masseur.active?
      '<span class="label label-danger">Suspended</span>'
    end
  end
  
  def map_url(address)
    "https://google.com/maps/place/#{CGI.escape(address.gsub("\n", ', '))}"
  end
  
  def profile_picture(masseur, size = :thumb)
    # Use their attached profile photo if it exists
    return masseur.profile_photo.url(size) if masseur.profile_photo_file_name.present?
    
    # Otherwise, see if they have any photos at all
    # If so, pick a safe, approved one at random.
    masseur.photos.approved.sfw.empty? ? '/no-picture.png' : masseur.photos.approved.sfw.sample.picture.url(size)
  end
  
  def renew_or_activate
    current_masseur.has_ever_subscribed? ? 'renew' : 'activate'
  end
  
  def progress_with_link(completion)
    # Return a link based on a masseur's current profile completion percentage
    if completion < 30
      link_to 'Complete your basic information to get to 30%', edit_masseur_registration_path
    elsif completion < 50 
      link_to 'Upload some photos to get to 50%',manage_masseur_photos_path(current_masseur)
    elsif completion < 75
      link_to 'Create an ad to get to 80%', new_masseur_ad_path(current_masseur)
    elsif completion < 100
      link_to 'Complete your extended details to get to 100%', edit_masseur_masseur_detail_path(current_masseur)     elsif completion < 100
    end
  end
  
  def screen_name_or_email(masseur)
    masseur.screen_name ? masseur.screen_name : masseur.email
  end
end
