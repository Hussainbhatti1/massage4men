class MasseursController < ApplicationController
  include RequireProfilePhoto

  skip_authorization_check only: [
    :kill_session,
    :add_basic_and_signup,
    :add_premium_and_signup,
    :switch_to_premium,
    :available_now
  ]

  # geocode_ip_address only: [:available_now]

  load_and_authorize_resource except: :available_now

  # RESTFUL ACTIONS
  def show
    @average = @masseur.review_average.round
    @supported_massage_types = @masseur.masseur_detail.massage_types.order(id: :asc)
    @ads = @masseur.ads.order(massage_type_id: :asc)

    @active_ad = params[:ad].present? ? params[:ad] : @ads.first.massage_type.name.downcase

    # Set a meaningful title based on the ad type
    @page_title = "#{@masseur.screen_name} | Gay #{@active_ad} massage in #{@masseur.masseur_detail.home_base_string(false, false)}"

     @incall_rates = @masseur.masseur_detail.rates.where(rate_type: RATE_INCALL).order(rate: :asc)
    @outcall_rates = @masseur.masseur_detail.rates.where(rate_type: RATE_OUTCALL).order(rate: :asc)

    # No need to record the impression because it gets called by ads#show_new
  end

  def new

  end

  def edit

  end

  def update
    if @masseur.update_attributes(masseur_params)
      redirect_to dashboard_masseur_path(@masseur), notice: 'Your account has been updated?!?!?!?!'
    else
      render :edit
    end

  end

  def notifications
    # Used for updating notification preferences
  end

  def dashboard
    @page_title = 'My Dashboard'

    @today_ad_views = current_masseur.ads.collect { |ad| ad.impressionist_count(start_date: Date.today.beginning_of_day) }.sum
    @month_ad_views = current_masseur.ads.collect { |ad| ad.impressionist_count(start_date: Date.today.beginning_of_month) }.sum
    @all_time_ad_views = current_masseur.ads.collect { |ad| ad.impressionist_count }.sum
  end

  # AVAILABILITY
  def available_now
    @page_title = 'Gay Massage and Male Masseurs Near You Available Now'
    origin = session[:geo_location]

    all_available_masseurs = MasseurDetail.joins(:masseur).where(masseurs: {available: true}).by_distance(origin: origin)

    @nearby_masseurs = all_available_masseurs.within(NEARBY_SEARCH_RADIUS, origin: origin)
    @other_masseurs = all_available_masseurs.beyond(NEARBY_SEARCH_RADIUS, origin: origin)
  end



  def become_available
    duration = params[:duration].to_i

    if current_user.update_attributes(available: true)
      flash['notice'] = "You have been marked as available for the next #{ActionController::Base.helpers.pluralize(duration, 'hour')}."

    else
      flash['error'] = 'You could not be marked as available.'
    end

    redirect_to :back
  end

  def become_unavailable

  end

  def toggle_availability
    if @masseur.available?
      @masseur.update_attributes(available: false)
    else
      @duration = params[:availability][:duration].to_i

      if @duration > BASIC_AVAILABILITY_LIMIT && !@masseur.premium?
        return render json: {success: false, error: "Availability for basic accounts is limited to #{BASIC_AVAILABILITY_LIMIT} hours."}, status: :unprocessable_entity
      end

      if @masseur.update_attributes(available: true)
        UnsetAvailabilityJob.set(wait: @duration.hours).perform_later(@masseur, @duration)
      end
    end
  end

  # FOLLOWING / UNFOLLOWING
  def favorite
    defav_url = defavorite_masseur_url(@masseur)

    begin
      current_user.favorite_masseurs << @masseur

    rescue
      render json: {success: false, error: 'Could not favorite masseur.', defavorite_url: defav_url}
    end

    render json: {success: true, msg: 'Masseur added to your favorites.', defavorite_url: defav_url}
  end

  def defavorite
    masseur_to_defavorite = current_user.favorites.find_by masseur: @masseur
    fav_url = favorite_masseur_url(@masseur)

    if masseur_to_defavorite && masseur_to_defavorite.destroy
      render json: {success: true, msg: 'Masseur removed from your favorites.', favorite_url: fav_url}
    else
      render json: {success: false, error: 'Could not defavorite masseur.', favorite_url: fav_url}
    end
  end

  # CRAP WE DON'T NEED ANYMORE
  def kill_session
    session[:m4m] = nil
    redirect_to root_path, notice: 'session[:m4m] set to nil'
  end

  def add_basic_and_signup
    session[:m4m][:ad_type] = 'basic'
    session[:m4m][:signup_in_progress] = true
    redirect_to :back, notice: 'Added session data.'
  end

  def add_premium_and_signup
    session[:m4m][:ad_type] = 'premium'
    session[:m4m][:signup_in_progress] = true
    redirect_to :back, notice: 'Added session data.'
  end

  def switch_to_premium
    session[:m4m][:ad_type] = 'premium'
    redirect_to :back
  end

  def photos

  end

  private
    def masseur_params
      params.require(:masseur).permit(
        :email,
        :first_name,
        :last_name,
        :dob,
        :contact_phone,
        :contact_phone_type,
        :mailing_address,
        :mailing_unit,
        :mailing_city,
        :mailing_state,
        :mailing_country,
        :mailing_zip,
        :provides_services_at_mailing_address,
        :profile_photo,
        :screen_name
      )
    end
end
