class Admin::BaseController < ApplicationController
  before_action :authenticate_admin!
  
  layout 'admin'
  
  private
  def setup_impersonation_data
    # Setup the data for our Impersonate buttons
    if session[:impersonating]
      @impersonate_data = {confirm: "You are currently impersonating #{(session[:impersonating]['screen_name'].present? ? session[:impersonating]['screen_name'] : session[:impersonating]['email'])}. You will be logged out of that account in order to impersonate this one. Are you sure you want to proceed?"}
    else
      @impersonate_data = nil
    end    
  end
  
  def current_ability
    @current_ability ||= AdminAbility.new(current_admin)
  end
end