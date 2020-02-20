class Admin::PromoCodesController < Admin::BaseController
  before_action :authenticate_admin!
  load_and_authorize_resource
  
  def index

  end
  
  def new
    
  end
  
  def edit
    
  end
  
  def update
    if @promo_code.update_attributes(promo_code_params)
      redirect_to admin_promo_codes_path, notice: 'Promo code edited.'
    else
      render :edit
    end
  end
  
  def create
    if @promo_code.save(promo_code_params)
      redirect_to admin_promo_codes_path, notice: 'Promo code saved.'
    else
      render :new
    end
  end
  
  def deactivate
    if @promo_code.deactivate
      flash[:notice] = "Successfully deactivated code #{@promo_code.code}."
    else
      flash[:error] = "The code #{@promo_code.code} could not be deactivated."
    end
    
    redirect_to :back
  end
  
  def activate
    if @promo_code.activate
      flash[:notice] = "Successfully activated code #{@promo_code.code}."
    else
      flash[:error] = "The code #{@promo_code.code} could not be activated."
    end
    
    redirect_to :back
  end

  private
  def promo_code_params
    params.require(:promo_code).permit(:code,
                                       :description,
                                       :start_date,
                                       :end_date,
                                       :active,
                                       :basic_discount_percentage,
                                       :premium_discount_percentage,
                                       :length_in_days)
  end
end
