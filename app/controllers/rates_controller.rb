class RatesController < ApplicationController
  before_action :authenticate_masseur!
  before_action :set_page_title
  
  load_and_authorize_resource :masseur
  load_and_authorize_resource :masseur_detail,
                              through: :masseur,
                              singleton: true
  load_and_authorize_resource through: :masseur_detail, except: :index
  
  def index
    if current_user.masseur_detail.nil?
      details_url = edit_masseur_masseur_detail_path(current_user)
      flash[:error] = "Please fill out your <a href=\"#{details_url}\" class=\"alert-link\">Details</a> before setting rates."
      redirect_to details_url
    else
      @rates = current_user.masseur_detail.rates
    end
  end
  
  def show

  end
  
  def update
    respond_to do |format|
      if @rate.update_attributes(rate_params)
        format.js {}
      else
        format.js { render json: {success: false, error: @rate.errors.full_messages.to_sentence}, status: :unprocessable_entity }
      end
    end
  end
  
  def create
    respond_to do |format|
      if @rate.save
        format.js {}
      else
        format.js { render json: {success: false, error: @rate.errors.full_messages.to_sentence}, status: :unprocessable_entity }
      end      
    end
  end
  
  def destroy
    respond_to do |format|
      if @rate.destroy
        format.js {}
      else
        format.js { render json: {success: false, error: @rate.errors.full_messages.to_sentence} }
      end
    end
  end
  
  private
  def set_page_title
    @page_title = 'My Rates'
  end
  
  def rate_params
    params.require(:rate).permit(:rate_type,
                                 :rate,
                                 :time,
                                 :description,
                                 :masseur_detail_id)
  end
end
