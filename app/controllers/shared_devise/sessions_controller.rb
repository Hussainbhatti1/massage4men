class SharedDevise::SessionsController < Devise::SessionsController
  # Sign in with either client or masseur from the same form
  before_action :store_user_location!, if: :storable_location?

  def create
    self.resource = warden.authenticate(auth_options)
    resource_name = self.resource_name

    if resource.nil?
      resource_name = :masseur
      request.params[:masseur] = params[:client]

      self.resource = warden.authenticate!(auth_options.merge(scope: :masseur))
    end
    
    # Don't allow inactive accounts to log in
    if !resource.active?
      # TODO: Make this more elegant than just immediately signing out
      # Perhaps implement Devise::Lockable?
      sign_out(resource)
      flash[:error] = t(:account_locked)
      return redirect_to root_path
    end

    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    
    session[:m4m] = nil
    respond_to do |format|
      format.html { redirect_to after_sign_in_path_for(resource) }
      format.json { render json: {success: true, redirect_url: after_sign_in_path_for(resource)} }
    end

    # respond_with resource, :location => after_sign_in_path_for(resource)
  end
  
  def new
    super do
      if request.xhr?
        return render 'new_modal', layout: false
      end      
    end
  end

  private

    def storable_location?
      current_client.present? && request.referer.include?('/masseurs')
    end

    def store_user_location!
      # :user is the scope we are authenticating
      store_location_for(:client, request.referrer)
    end

    def after_sign_in_path_for(resource_or_scope)
      stored_location_for(resource_or_scope) || super
    end
end