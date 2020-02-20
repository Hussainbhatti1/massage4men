class PhotosController < ApplicationController
  before_action :authenticate_masseur!
  before_action :set_page_title
  load_and_authorize_resource :masseur
  load_and_authorize_resource through: :masseur, shallow: true
  
  def index

  end
  
  def manage
    
  end
  
  def new
    render layout: false
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def create
    if @photo.save
      redirect_to manage_masseur_photos_path(current_masseur), notice: 'Your photo has been saved. You will be notified when it has been approved.'
    else
      render :new
    end
  end
  
  def destroy
    respond_to do |format|
      if @photo.destroy
        format.html { redirect_to :back, notice: 'Photo deleted.' }
        format.js {}
      else
        format.html { 
          flash[:error] = 'Photo could not be deleted.'
          redirect_to :back
        }
        
        format.js { render json: {success: false}, status: :unprocessable_entity }
      end
    end
  end
  
  private
  def set_page_title
    @page_title = 'My Photos'
  end
  
  def photo_params
    params.require(:photo).permit(:adult, :picture)
  end
end
