class ClientsController < ApplicationController  
  include RequireProfilePhoto
  load_and_authorize_resource
    
  def show
    redirect_to dashboard_client_path
  end
  
  def favorites
    
  end
  
  def reviews
    
  end

  def update
    if @client.update_attributes(client_params)
      redirect_to dashboard_client_path(@client), notice: 'Your account has been updated.'
    else
      render :edit
    end
  end

  private
  def client_params
    params.require(:client).permit(
      :profile_photo
    )
  end
end
