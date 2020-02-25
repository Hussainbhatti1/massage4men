class AdsController < ApplicationController
  before_action :authenticate_masseur!, except: [:show, :show_new, :search, :therapeutic, :sensual, :relaxation, :customized]
  before_action :set_page_title, except: [:show, :search, :therapeutic, :sensual, :relaxation, :customized]
  skip_authorization_check only: [:show, :search, :therapeutic, :sensual, :relaxation, :customized]
  
  # Always load the masseur and ad
  load_resource :masseur
  load_resource  
  
  # Don't always authorize it
  authorize_resource :masseur, except: [:show, :search, :therapeutic, :sensual, :relaxation, :customized]
  authorize_resource except: [:show, :search, :therapeutic, :sensual, :relaxation, :customized]
  
  def therapeutic
    # ad_by_type('Therapeutic')
    redirect_to_ad_type('therapeutic')
  end
  
  def relaxation
    # /masseurs/:masseur_id/relaxation (relaxation_ad_masseur_path)
    redirect_to_ad_type('relaxation')
  end

  def sensual
    redirect_to_ad_type('relaxation')
  end

  def customized
    redirect_to_ad_type('customized')
  end
  
  def manage
    @local_ads = current_user.ads
    @travel_ads = []
  end

  def index
    if signup_in_progress
      @ads = []
      
      if signup_ad_type == 'basic'
        # Create one Ad object
        @ads << current_masseur.ads.build
      elsif signup_ad_type == 'premium'
        1.upto(3) do
          @ads << current_masseur.ads.build
        end
      end
    end    
  end
  
  def edit
    
  end
  
  def show
    # We have @ad loaded, so...
    redirect_to_ad_type(@ad.massage_type.name.downcase)
  end
  
  def show_new
    record_impression
    render layout: false
  end
  
  def new
    
  end
  
  def create
    # Assign ad to the masseur
    @ad.masseur = current_masseur
        
    # Assign ad params and photos
    # @ad = current_masseur.ads.build(ad_params)

    respond_to do |format|
      if @ad.save
        # Assign primary photo
        if params[:primary_photo_id].present?
          @ad.ad_photos.find_by(photo_id: params[:primary_photo_id]).set_primary      
        end
        
        format.html { redirect_to manage_masseur_ads_path(current_user), notice: "Your #{@ad.massage_type.name} ad has been saved." }
        format.js {}
        format.json { render json: {success: true} }
      else
        # Ad did not save
        format.html {
          flash[:error] = 'There was a problem saving your ad.'
          redirect_to :back
        }

        format.js { }
        format.json { render json: {success: false} }
      end
    end
  end
  
  def update
    if @ad.update_attributes(ad_params)
      # Unset the current primary photos
      if(@ad.primary_photo)
        @ad.primary_photo.unset_primary
      end
      
      # Set the primary photo
      if params[:primary_photo_id].present?
        @ad.ad_photos.find_by(photo_id: params[:primary_photo_id]).set_primary
      end

      redirect_to manage_masseur_ads_path(current_user), notice: "Your #{@ad.massage_type.name} ad has been updated."
    else
      flash[:error] = 'Your ad could not be saved.'
      redirect_to :back
    end
  end
  
  def destroy
    massage_type = @ad.massage_type.name
    
    if @ad.destroy
      flash[:notice] = "Your #{massage_type} ad has been deleted."
    else
      flash[:error] = 'There was a problem deleting your ad.'
    end
    
    redirect_to :back
  end
  
  def search
    @page_title = 'Find a Gay Massage or Male Masseurs Near You'
    # So we don't see the search widget in the top right on the next page
    @hide_search = false
    @location_string = params[:search] && params[:search][:location]
    @massage_types = (params[:search] && params[:search][:massage_types].presence) || MassageType.all.pluck(:id)
    @distance = (params[:search] && params[:search][:distance].presence || 300).to_i if request.post?
    @massage_types.reject!(&:blank?)

    if (request.post? && (@location_string.empty? && @massage_types.empty?))
      flash[:error] = 'Invalid search query.'
      return redirect_to :back
    else
      

      if @location_string.present?
        masseur_details = MasseurDetail.all

        # Check for airport code
        airport = Airport.find_by(code: @location_string.upcase)
        if airport.present?
          masseur_details = masseur_details.near(airport.to_coordinates, @distance*1.6)
        else
          masseur_details = masseur_details.near(@location_string, @distance*1.6)
        end

        masseurs_ids = masseur_details.map(&:masseur_id)
        @masseurs = Masseur.all
      else
        @masseurs = Masseur.all
      end
    end
  end
  
  private
  def redirect_to_ad_type(ad_type)
    # Make sure the client has asked for a valid ad type
    if MassageType.all.collect { |t| t.name.downcase }.include? ad_type
      redirect_to masseur_path(@masseur, params: { ad: ad_type } ), status: 301
    else
      flash[:error] = "Invalid ad type #{ad_type}."
      redirect_to :back
    end
  end
  
  def set_page_title
    @page_title = 'My Ads'
  end
  
  def ad_params
    params.require(:ad).permit( :masseur_id,
                                :massage_type_id,
                                :about_me,
                                :about_my_services,
                                :primary_photo,
                                :photo_ids => [])
  end
  
  def geocode_to_string(geocode)
    str = ''
    
    if geocode.city.present?
      str = geocode.city
    end
    
    if geocode.state.present?
      str += ', ' + geocode.state
    end
    
    if geocode.zip.present?
      str += ' ' + geocode.zip
    end
    
    if geocode.country.present? && geocode.country != 'United States'
      str += ', ' + geocode.country
    end
    
    str    
  end
  
  def load_rates
    @incall_rates = @ad.masseur.masseur_detail.rates.where(rate_type: RATE_INCALL).order(rate: :asc)
    @outcall_rates = @ad.masseur.masseur_detail.rates.where(rate_type: RATE_OUTCALL).order(rate: :asc)
  end
  
  def record_impression
    impressionist(@ad, unique: [:session_hash])
  end
  
  def ad_by_type(ad_type)
    # Make sure that the type is correct
    available_types = MassageType.all.collect { |t| t.name }
    
    if !available_types.include? ad_type
      flash[:error] = 'Ad not found.'
      redirect_to root_path      
    else
      @ad = @masseur.ad_by_type(ad_type)
    
      if @ad
        load_rates
        record_impression

        @page_title = "#{@masseur.screen_name} | #{ad_type.downcase} gay massage in #{@ad.masseur_detail.home_base_string(false, false)}"

        render :show
      else
        flash[:error] = 'Ad not found.'
        redirect_to root_path
      end        
    end
  end  
end
