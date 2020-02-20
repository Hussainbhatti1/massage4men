class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  add_flash_types :success, :danger, :info

  devise_group :user, contains: [:client, :masseur]

  before_action :set_locale
  before_action :load_settings
  before_action :initialize_m4m_session
  before_action :normalize_location
  before_action :generate_impersonation_paths, if: 'session[:impersonating] && admin_signed_in?'
  before_action :set_referral_code

  # before_action :set_pic_required,
  #               if: 'masseur_signed_in? && !current_masseur.has_profile_photo?',
  #               except: :upload_profile_photo

  check_authorization unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_referral_code
    # If a referral code was passed, check it for validity
    if params[:refer]
      @tracking_link = TrackingLink.find_by code: params[:refer]

      if @tracking_link && @tracking_link.usable?
        # Set cookie if its usable
        # If you hit two links in a row, the second will overrule the first
        cookies[:refer] = @tracking_link.code

        # Save the impression
        impressionist(@tracking_link, 'Link hit', unique: [:ip_address])
      end
    end
  end

  def normalize_location
    if session[:geo_location].kind_of? Hash
       # session[:geo_location] = Geocoder.search(lat: session[:geo_location]['lat'],lng: session[:geo_location]['lng'])
      session[:geo_location] = Geocoder.search([session[:geo_location]['lat'],session[:geo_location]['lng']])
      session[:geo_location] = session[:geo_location].first.address if session[:geo_location].present?
    else
      logger.debug "Cannot normalize location for a #{session[:geo_location].class}."
    end
  end

  # http://guides.rubyonrails.org/i18n.html#setting-the-locale-from-the-url-params
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def load_settings
    @settings ||= SiteSetting.first
  end

  # Give this a value, every time
  # def current_user
  #   if client_signed_in?
  #     current_client
  #   elsif masseur_signed_in?
  #     current_masseur
  #   else
  #     false
  #   end
  # end

  helper_method :current_user

  def after_sign_in_path_for(resource)
    if resource.kind_of? Masseur
      dashboard_masseur_path(current_masseur)
    elsif resource.kind_of? Client
      dashboard_client_path(current_client)
    else
      super
    end
  end

  def redirect_to_back_or_root
    redirect_to (request.env["HTTP_REFERER"].present? ? request.env["HTTP_REFERER"] : root_path)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, :alert => exception.message
  end

  def initialize_m4m_session
    session[:m4m] ||= {}
  end

  def signup_in_progress
    session[:m4m]['signup_in_progress']
  end

  def signup_ad_type
    session[:m4m]['ad_type']
  end

  def generate_impersonation_paths
    if current_user.kind_of? Masseur
      @impersonation_dashboard_path = dashboard_masseur_path(current_user)
      @unimpersonate_path = unimpersonate_admin_masseur_path(current_user)
    elsif current_user.kind_of? Client
      @impersonation_dashboard_path = dashboard_client_path(current_user)
      @unimpersonate_path = unimpersonate_admin_client_path(current_user)
    end
  end

  private
  def set_pic_required
    @pic_required = true
    @pic_upload_url = send("upload_profile_photo_#{current_user.class.to_s.downcase}_url", current_user)
    # redirect_to send("upload_profile_photo_#{current_user.class.to_s.downcase}_path", current_user)
  end
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :screen_name, :mailing_zip, :dob, :contact_phone,:show_number, :profile_photo, :tracking_link_id])
  end
end
