class Admin::TrackingLinksController < Admin::BaseController
  before_action :authenticate_admin!
  load_and_authorize_resource

  def index
    @tracking_links = @tracking_links.page(params[:page])
  end
  
  def new
    
  end
  
  def edit
    
  end
  
  def create
    if @tracking_link.save
      redirect_to admin_tracking_links_path, notice: 'Tracking link created!'
    else
      render :new
    end
  end
  
  def update
    if @tracking_link.update_attributes(tracking_link_params)
      redirect_to admin_tracking_links_path, notice: 'Tracking link updated!'
    else
      render :edit
    end
  end
  
  def destroy
    @tracking_link.destroy
    redirect_to :back, notice: 'Tracking link deleted.'
  end
  
  private
  def tracking_link_params
    params.require(:tracking_link).permit(:code, :source, :notes)
  end    
end
