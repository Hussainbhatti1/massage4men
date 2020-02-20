class Admin::DashboardController < Admin::BaseController
  skip_authorization_check
  
  def index
    @photo_queue = Photo.unapproved.order(created_at: :desc)
    @unapproved_users = Masseur.unapproved.order(created_at: :desc)
  end

end
