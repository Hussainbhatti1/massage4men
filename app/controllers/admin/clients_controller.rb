class Admin::ClientsController < Admin::BaseController
  load_and_authorize_resource

  def impersonate
    # Sign in an arbitrary user without credentials. Be careful!
    session[:impersonating] = @client
    sign_in_and_redirect(@client)
  end
  
  def unimpersonate
    # Sign out the impersonated user and clear the session var
    screen_name = @client.screen_name
    
    if sign_out(@client)
      session[:impersonating] = nil
      redirect_to admin_clients_path, notice: "You are no longer impersonating #{screen_name}."
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
      'city',
      'state',
      'active',
      'created_at'
    ]
    
    order_whitelist = ['asc', 'desc']
    
    if params[:sort]
      if sort_whitelist.include? params[:sort]
        sort = params[:sort]
      else
        flash[:error] = 'Invalid sort parameter.'
        redirect_to admin_clients_path
      end
    else
      sort = 'id'
    end
    
    if params[:order]
      if order_whitelist.include? params[:order]
        order = params[:order]
      else
        flash[:error] = 'Invalid direction parameter.'
        redirect_to admin_clients_path
      end
    else
      order = 'desc'
    end
        
    @clients = @clients.order("#{sort} #{order}").page(params[:page])   

    # Setup the data for our Impersonate buttons
    if session[:impersonating]
      setup_impersonation_data
    end
  end
  
  def suspend
    respond_to do |format|
      if @client.update_attribute('active', false)
        format.js {}
        format.html { redirect_to :back, notice: 'Client suspended.'}
      else
        format.js { render json: {success: false}, status: :unprocessable_entity }
        format.html { 
          flash[:error] = 'Client could not be suspended.'
          redirect_to :back 
        }
      end
    end    
  end
  
  def unsuspend
    respond_to do |format|
      if @client.update_attribute('active', true)
        format.js {}
        format.html { redirect_to :back, notice: 'Client unsuspended.'}
      else
        format.js { render json: {success: false}, status: :unprocessable_entity }
        format.html { 
          flash[:error] = 'Masseur could not be unsuspended.'
          redirect_to :back 
        }
      end
    end    
  end
  
  def search
    @clients = Client.search(params[:search].keys, params[:search].values).page(params[:page])
  end
  
  def edit
    flash[:error] = 'Editing clients is not yet supported.'
    redirect_to :back
  end
end
