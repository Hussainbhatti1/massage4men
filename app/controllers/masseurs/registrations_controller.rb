class Masseurs::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_sign_up_params, only: [:create]
  before_filter :configure_account_update_params, only: [:update]
  respond_to :json, only: :create

  def new
    # Set session var to track signup progress
    session[:m4m][:signup_in_progress] = true

    # Set ad type selected, if passed as a GET variable
    if params[:ad_type] && AD_TYPES.include?(params[:ad_type])
      session[:m4m][:ad_type] = params[:ad_type]
    end

    super do
      if cookies[:refer]
        resource.tracking_link = TrackingLink.find_by code: cookies[:refer]
      end

      return render 'new_modal', layout: false
    end
  end

  def edit
    @page_title = 'My Masseur Account'
  end

  def update
    current_user.update(update_params) if current_user.present?
      render 'edit'
  end

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
        super do
          # Clear cookies if the model saved successfully
          if resource.persisted? && cookies[:refer]
            cookies[:refer] = nil
          end

          # Respond appropriately
          respond_to do |format|
            if resource.persisted? && resource.active_for_authentication?
              # Sign in the new user
              resource_update(params)
              sign_up(resource_name, resource)
              resource.update(profile_photo: params[:masseur][:profile_photo])
              resource.update(confirmed_at: DateTime.now)
              # CHANGED 05/04/2017: All masseur registrations result in a Trial
              # Did he use a promo code?
              if resource.tracking_link && resource.tracking_link.promo_code
                promo = resource.tracking_link.promo_code
                length_in_days = promo.length_in_days
              else
                length_in_days = DEFAULT_TRIAL_LENGTH_IN_DAYS
              end

              trial = resource.build_trial(
                promo_code: (promo ? promo : nil),
                subscription_type: SUBSCRIPTION_PREMIUM,
                active: true,
                seven_day_email_sent: false,
                fourteen_day_email_sent: false,
                ends_at: length_in_days.days.from_now.end_of_day
              )

              trial.save
              flash[:success] = "Code accepted! Enjoy your #{length_in_days}-day trial. We'll notify you when it's about to expire."

              ret = {
                success: true,
                payment_required: false,
                dashboard_url: dashboard_masseur_path(resource)
              }

              # Determine where to redirect:
              # if resource.tracking_link && resource.tracking_link.promo_code
              #   # If user used a TrackingLink with a PromoCode, find out if the PromoCode requires payment for their subscription type.
              #   subscription_type = (session[:m4m]['ad_type'] == 'premium' ? SUBSCRIPTION_PREMIUM : SUBSCRIPTION_BASIC)
              #
              #   if !resource.tracking_link.promo_code.requires_payment?(subscription_type)
              #     # If no payment is required, create a Trial for the user...
              #     # HACK: This is repeated from PromoCodesController:23. DRY it out.
              #     trial = resource.build_trial(promo_code: resource.tracking_link.promo_code,
              #                                 subscription_type: subscription_type,
              #                                 active: true,
              #                                 seven_day_email_sent: false,
              #                                 fourteen_day_email_sent: false,
              #                                 ends_at: resource.tracking_link.promo_code.length_in_days.days.from_now.end_of_day)
              #
              #     trial.save
              #
              #     flash[:success] = "Code accepted! Enjoy your #{resource.tracking_link.promo_code.length_in_days}-day trial. We'll notify you when it's about to expire."
              #
              #     # ...and redirect them to their dashboard
              #     ret = {
                    # success: true,
                    # payment_required: false,
                    # dashboard_url: dashboard_masseur_path(resource)
              #     }
              #   else
              #     ret = { success: true,
              #             payment_required: true,
              #             next_page_url: new_masseur_subscription_path(resource),
              #             dashboard_url: dashboard_masseur_path(resource)
              #           }
              #   end
              # else
              #   ret = { success: true,
              #           payment_required: true,
              #           next_page_url: new_masseur_subscription_path(resource),
              #           dashboard_url: dashboard_masseur_path(resource)
              #         }
              # end

              format.json { return render json: ret, status: :ok }
            else
              format.json { return render json: { success: false, errors: resource.errors }, status: :unprocessable_entity }
            end
          end
        end
      end
  end


  def resource_update(params)
    resource.screen_name  = params[:masseur][:screen_name]
    resource.mailing_zip  = params[:masseur][:mailing_zip]
    resource.mailing_city  = params[:masseur][:mailing_city]
    resource.mailing_state  = params[:masseur][:mailing_state]
    resource.dob          = params[:masseur][:dob]
    resource.contact_phone = params[:masseur][:contact_phone]
    resource.profile_photo_file_name = params[:masseur][:profile_photo]
    resource.tracking_link_id = params[:masseur][:tracking_link_id]
    resource.save
  end

  protected
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(sign_up: [:screen_name, :mailing_zip, :dob, :contact_phone,:show_number, :profile_photo, :tracking_link_id, :email])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(account_update: [:password, :password_confirmation, :first_name, :last_name, :screen_name, :mailing_address, :mailing_unit, :mailing_city, :mailing_state, :mailing_country, :mailing_zip, :dob, :contact_phone, :contact_phone_type, :provides_services_at_mailing_address, :profile_photo, :notify_when_availability_expires])
  end

  def update_params
    params.require(:masseur).permit(:first_name, :last_name, :screen_name, :mailing_address, :mailing_unit, :mailing_city, :mailing_state, :mailing_country, :mailing_zip, :dob, :contact_phone, :contact_phone_type, :provides_services_at_mailing_address, :profile_photo, :notify_when_availability_expires, :email)
  end

  def after_sign_in_path_for(resource)
    # If this masseur is new (i.e. doesn't have a MasseurDetail model), force them to make one
    # TODO: Change this!
    if !resource.masseur_detail
      session[:m4m][:signup_in_progress] = true
      new_masseur_masseur_detail_path(resource)
    else
      root_path
    end
  end

  def after_update_path_for(resource)
    return request.referer if request.referer

    edit_masseur_registration_path
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
