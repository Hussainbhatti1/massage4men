class Admin::SessionsController < Devise::SessionsController
  layout 'admin_login'
  
  def create
    if user_signed_in?
      flash[:success] = "You have been signed out of the regular user <strong>#{current_user.screen_name}.</strong>"
      sign_out(current_user)
    end
    
    super
  end  
end