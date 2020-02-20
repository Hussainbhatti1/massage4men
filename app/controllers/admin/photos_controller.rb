class Admin::PhotosController < Admin::BaseController
  before_action :authenticate_admin!
  
  load_and_authorize_resource
  
  def approval_queue
    @photo_queue = Photo.unapproved.order(created_at: :desc)
  end
  
  def approve
    respond_to do |format|
      if @photo.approve
        @photo_queue = Photo.unapproved.order(created_at: :desc)
        format.js { }
      else
        format.js { render json: {success: false}, status: :unprocessable_entity }
      end
    end
  end
  
  def approve_as_adult
    respond_to do |format|
      if @photo.approve_as_adult
        @photo_queue = Photo.unapproved.order(created_at: :desc)
        format.js { }
      else
        format.js { render json: {success: false}, status: :unprocessable_entity }
      end
    end    
  end
  
  def deny
    respond_to do |format|
      if @photo.deny
        @photo_queue = Photo.unapproved.order(created_at: :desc)
        format.js { }
      else
        format.js { render json: {success: false}, status: :unprocessable_entity }
      end
    end
  end
end
