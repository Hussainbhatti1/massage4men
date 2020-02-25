class Clients::RegistrationsController < Devise::RegistrationsController
before_filter :configure_sign_up_params, only: [:create]
before_filter :configure_account_update_params, only: [:update]
respond_to :js
respond_to :json, only: :create

  # GET /resource/sign_up
  # def new
  #   super
  # end

  def new
    super do
      # We don't do tracking cookies on clients yet.
      # if cookies[:refer]
      #   resource.tracking_link = TrackingLink.find_by code: cookies[:refer]
      # end
      @source = params[:source]
      @recipient = Masseur.find_by_id(params[:masseur_id])
      return render 'new_modal', layout: false
    end
  end


  # POST /resource
  def create
    if !verify_recaptcha
      flash.delete :recaptcha_error
      build_resource(sign_up_params)
      resource.valid?
      resource.errors.add(:base, "There was an error with the recaptcha code below. Please re-enter the code.")
      clean_up_passwords(resource)
      respond_with_navigational(resource) { render_with_scope :new }
      else
      flash.delete :recaptcha_error
      # TODO: DRY this up from Masseurs::Registrations
      super do

        # Clear cookies if the model saved successfully
        if resource.persisted? && cookies[:refer]
          cookies[:refer] = nil
        end

        # Respond appropriately
        respond_to do |format|
          if resource.persisted? && resource.active_for_authentication?
            resource_update(params)

            # Sign in the new user
            sign_up(resource_name, resource)

            # Return a JSON object with the link to redirect to
            ret = {
              success: true,
              payment_required: false
            }
            ret[:dashboard_url] = dashboard_client_path(resource) if params[:client][:source].blank?

            format.json { return render json: ret, status: :ok }
          else
            format.json { return render json: { success: false, errors: resource.errors }, status: :unprocessable_entity }
          end # / resource.persisted?
        end # / respond_to
      end # / super do

      # super do
      #   # If we're doing an AJAX signup, set :age_verified so the model doesn't try a full validation
      #   # if params[:client][:age_verified]
      #   #   resource.age_verified = params[:client][:age_verified]
      #   # end
      # end
      # super
    end
  end # / create

  # GET /resource/edit
  def edit

  end

  def update
    current_user.update(update_params)
    super
  end
  # PUT /resource

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  #email: nil, first_name: nil, last_name: nil, city: nil, state: nil, zip: nil, dob: nil, date: nil, phone: nil, phone_type: nil, email_new_masseurs: nil, email_masseur_profile_update: nil, email_weekly_update: nil, created_at: nil, updated_at: nil, latitude: nil, longitude: nil, profile_photo_file_name: nil, profile_photo_content_type: nil, profile_photo_file_size: nil, profile_photo_updated_at: nil, screen_name: nil
  def resource_update(params)
    resource.screen_name  = params[:client][:screen_name]
    resource.zip  = params[:client][:zip]
    resource.dob          = params[:client][:dob]
    resource.save
  end

  protected
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(sign_up: [:first_name, :last_name, :city, :state, :country, :zip, :dob, :screen_name, :phone, :phone_type, :email_new_masseurs, :email_masseur_profile_update, :email_weekly_update, :profile_photo, :age_verified])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(account_update: [:password, :password_confirmation, :first_name, :last_name, :city, :state, :country, :zip, :dob, :screen_name, :phone, :phone_type, :email_new_masseurs, :email_masseur_profile_update, :email_weekly_update, :profile_photo])
  end

  def update_params
    params.require(:client).permit(:first_name, :last_name, :city, :state, :country, :zip, :dob, :screen_name, :phone, :phone_type, :email_new_masseurs, :email_masseur_profile_update, :email_weekly_update, :profile_photo)
  end

  def after_update_path_for(resource)
    return request.referer if request.referer

    edit_client_registration_path
  end

  def update_resource(resource, params)
    if needs_password?(resource, params)
      resource.update_with_password(params)
    else
      params.delete(:current_password)
      resource.update_without_password(params)
    end
  end

  def needs_password?(user, params)
    (params[:email].present? && user.email != params[:email]) || params[:password].present?
  end
end
