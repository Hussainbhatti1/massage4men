class StaticPagesController < ApplicationController
  include Carmen

  skip_authorization_check
  # geocode_ip_address only: :home

  def home
    @page_title = 'Gay Massage, Bodywork and Male Masseurs Near You'
    # If we have a location...
    if session[:geo_location]
      loc = session[:geo_location]
      @featured_masseurs = Masseur.joins(:masseur_detail).joins(:photos).joins(:ads).where(featured: true)
      if @featured_masseurs.count > 0
        # Find the closest featured masseur to the current user, no matter where they're located
        @masseurs = Masseur.near(loc, 500, min_radius: 100)
        @featured_masseurs = @masseurs.joins(:masseur_detail).joins(:photos).joins(:ads).where(featured: true)
        @featured_masseur = @featured_masseurs.present? ? @featured_masseurs.first : Masseur.last

        # @featured_masseur_detail = MasseurDetail.joins(:masseur)
        #                                         .where(masseurs: {featured: true})
        #                                         .closest(origin: loc).random
        @featured_masseur_detail = @featured_masseur.masseur_detail

        # @featured_masseur = @featured_masseur_detail.masseur
        @distance_to_featured_masseur = @featured_masseur_detail.distance_to(loc).round
      end
    end

    @display_jumbotron = true
  end

  def advertise

  end

  def get_location
    search = Geocoder.search([params[:lat], params[:lng]])
    if search.present?
      @location = search.first.address
      render json: {address: @location}
    else

    end
  end

  def contact
    if request.post?
      @contact = ContactForm.new

      if current_user
        @contact.name = current_user.full_name
        @contact.email = current_user.email

        @contact.account_type = (current_user.kind_of?(Client) ? 'Client' : 'Masseur')
        @contact.account_id = current_user.id
      else
        @contact.name = params[:contact][:name]
        @contact.email = params[:contact][:email]
        @contact.account_type = 'Unregistered'
      end

      @contact.message = params[:contact][:message]
      @contact.request = request

      if verify_recaptcha(model: @contact) && @contact.deliver
        redirect_to root_path, notice: 'Your message has been sent.'
      else
        render :contact
      end
    else
      @contact = ContactForm.new
    end
  end

  def show
    @static_page = StaticPage.find_by_id(params[:id])

    if @static_page.blank?
      @static_page = StaticPage.find_by_slug(params[:id])
    end
  end

  def signup
    # Controller action for step 1 of signup (choosing masseur or client)
    render layout: false
  end

  # Returns a JSON list of params[:country_code]'s subregions from Carmen
  def country_info
    begin
      # Grab the phone format
      phone_info = PHONE_FORMATS.select { |format| format[:country] == params[:country_code] }.first

      if phone_info
        phone_mask = phone_info[:phone_format]
        use_postal_code = phone_info[:use_postal_code]
      else
        phone_mask = nil
        use_postal_code = true
      end

      render json: {
        success: true,
        subregions: Country.coded(params[:country_code]).subregions.collect { |s| [s.name, s.code] },
        phone_format: phone_mask,
        use_postal_code: use_postal_code
      }, status: :ok
    rescue
      render json: { success: false, error: 'Invalid country code.' }, status: :unprocessable_entity
    end
  end
end
