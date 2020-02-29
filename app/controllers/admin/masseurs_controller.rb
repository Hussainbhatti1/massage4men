class Admin::MasseursController < Admin::BaseController
  load_and_authorize_resource

  def send_reminder
    @masseur = Masseur.find(params[:id])
    @completion = @masseur.calculate_completeness


    MasseurMailer.completion_reminder(@masseur, @completion).deliver_now
    redirect_to uncompleted_profile_admin_masseurs_path, notice: 'Reminder email sent successfully.'
  end


  def send_bulk_reminder
    Masseur.all.each do |masseur|
      if !masseur.complete?
        @completion = masseur.calculate_completeness
        MasseurMailer.completion_reminder(masseur, @completion).deliver_now
      end
    end

    redirect_to uncompleted_profile_admin_masseurs_path, notice: 'Reminder email sent successfully.'
  end

  def impersonate
    # Sign in an arbitrary user without credentials. Be careful!
    session[:impersonating] = @masseur
    sign_in_and_redirect(@masseur)
  end

  def unimpersonate
    # Sign out the impersonated user and clear the session var
    screen_name = @masseur.screen_name

    if sign_out(@masseur)
      session[:impersonating] = nil
      redirect_to admin_masseurs_path, notice: "You are no longer impersonating #{screen_name}."
    else
      sign_out_all_scopes
      flash[:error] = "Could not stop impersonating #{screen_name}, so all scopes have been logged out instead. Sorry for the inconvenience."
      redirect_to root_path
    end
  end

  def index
    sort_whitelist = [
      'id',
      'first_name',
      'last_name',
      'screen_name',
      'email',
      'mailing_city',
      'mailing_state',
      'active',
      'approved',
      'featured'
    ]

    order_whitelist = ['asc', 'desc']

    if params[:sort]
      if sort_whitelist.include? params[:sort]
        sort = params[:sort]
      else
        flash[:error] = 'Invalid sort parameter.'
        redirect_to admin_masseurs_path
      end
    else
      sort = 'id'
    end

    if params[:order]
      if order_whitelist.include? params[:order]
        order = params[:order]
      else
        flash[:error] = 'Invalid direction parameter.'
        redirect_to admin_masseurs_path
      end
    else
      order = 'desc'
    end
    options={}
    options={is_deleted: false, active: true }

    @masseurs = @masseurs.joins('LEFT OUTER JOIN masseur_details ON masseur_details.masseur_id = masseurs.id').where(options).order("#{sort} #{order}").page(params[:page]).per(10)
    # @masseurs = @masseurs.joins(:masseur_detail).order("#{sort} #{order}").page(params[:page])
    # Setup the data for our Impersonate buttons
    if session[:impersonating]
      setup_impersonation_data
    end
  end

  def show
    render layout: false
  end

  def edit

  end

  def upload_photo
    @photo=Photo.find(params[:photo][:id])
    @photo.update_attributes(picture: params[:picture])
  @photos= Photo.where(approved:false).page(params[:page])
  respond_to do |format|
    format.js
  end
 # render partial: 'admin/shared/photo_queue_table', locals: {photo_queue: @photos}
  end

  def update
    if @masseur.update_attributes(masseur_params)
      redirect_to admin_masseurs_path, notice: 'Masseur successfully updated.'
    else
      render :edit
    end
  end

  def search
    @masseurs = Masseur.search(params[:search].keys, params[:search].values).page(params[:page])
  end

  # APPROVAL/DENIAL
  def approval_queue
    @unapproved_users = Masseur.unapproved.order(created_at: :desc)
  end

  def uncompleted_profile
    @masseurs = Masseur.all.page(params[:page])
  end

  def unapprove
    respond_to do |format|
      if @masseur.update_attributes(approved: false)
        format.js {}
      else
        format.js { render json: {success: false}, status: :unprocessable_entity }
      end
    end
  end

  def approve
    respond_to do |format|
      if @masseur.approve
        format.js { }
      else
        format.js { render json: {success: false}, status: :unprocessable_entity }
      end
    end
  end

  def deny
    # UPDATE: Denying a masseur deletes him entirely.
    respond_to do |format|
      if @masseur.destroy#deny
        format.js { }
      else
        format.js { render json: {success: false}, status: :unprocessable_entity }
      end
    end
  end

  # SUSPENSION: Different from approval/denial!
  # Suspension prevents an account from appearing on the site or logging in
  def suspend
    respond_to do |format|
      if @masseur.update_attributes(active: false)
        format.js {}
        format.html { redirect_to :back, notice: 'Masseur suspended.'}
      else
        format.js { render json: {success: false}, status: :unprocessable_entity }
        format.html {
          flash[:error] = 'Masseur could not be suspended.'
          redirect_to :back
        }
      end
    end
  end

  def unsuspend
    respond_to do |format|
      if @masseur.update_attributes(active: true)
        format.js {}
        format.html { redirect_to admin_masseurs_path, notice: 'Masseur unsuspended.'}
      else
        format.js { render json: {success: false}, status: :unprocessable_entity }
        format.html {
          flash[:error] = 'Masseur could not be unsuspended.'
          redirect_to :back
        }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @masseur.update_attributes(is_deleted:true )
        format.js { }
        format.html { }
      else
        format.js { render json: {success: false}, status: :unprocessable_entity }
        format.html { }
      end
    end
  end

  def unblock
      if @masseur.update_attributes(is_deleted:false)
        redirect_to admin_masseurs_path, notice: 'Masseur has been unblocked Succesfully'
      else
        redirect_to admin_masseurs_path, notice: "Unable to unblock Masseur "
      end
    end

  def blocked_history
    @masseurs=Masseur.blocked.order(created_at: :desc).page(params[:page])
  end

  def suspended_history
    @masseurs=Masseur.suspended.order(created_at: :desc).page(params[:page])
  end

  def site_setting_report
    @site_reports = AdminsSiteSettingLog.all.page(params[:page])
  end

  def update_image

  end

  private
  def masseur_params
    params.require(:masseur).permit(
      :profile_photo,
      :first_name,
      :last_name,
      :mailing_address,
      :mailing_unit,
      :mailing_city,
      :mailing_state,
      :mailing_zip,
      :contact_phone,
      :contact_phone_type,
      :provides_services_at_mailing_address,
      :approved,
      :featured,
      :available,
      :screen_name
    )
  end
end
