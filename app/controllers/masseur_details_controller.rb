class MasseurDetailsController < ApplicationController
  before_action :authenticate_masseur!
  before_action :new_if_new, only: :edit
  before_action :set_page_title
  
  load_and_authorize_resource :masseur
  load_and_authorize_resource :masseur_detail,
                              through: :masseur,
                              singleton: true

  def new    
    # Nested models
    @services = @masseur_detail.services.build
    @massage_techniques = @masseur_detail.massage_techniques.build
    @massage_products = @masseur_detail.massage_products.build
    @massage_types = @masseur_detail.massage_types.build
  end
  
  def edit
    
  end
  
  def create
    if @masseur_detail.save
      redirect_to dashboard_masseur_path(current_masseur), notice: 'Your details have been saved.'
    else
      render :new
    end
  end
  
  def update
    if @masseur_detail.update_attributes(masseur_detail_params)
      redirect_to dashboard_masseur_path(current_masseur), notice: 'Your details have been updated!'
    else
      render :edit
    end
  end

  private
  def new_if_new
    # Force creation of a new MasseurDetail record if one doesn't exist
    if !current_masseur.masseur_detail
      redirect_to new_masseur_masseur_detail_path(current_masseur)
    end
  end
  
  def set_page_title
    @page_title = 'My Masseur Account'
  end
  
  def masseur_detail_params
    params.require(:masseur_detail).permit(
      :display_real_age,
      :display_age,
      :home_base_city,
      :home_base_state,
      :home_base_zip,
      :home_base_country,
      :height_feet,
      :height_inches,
      :height_cm,
      :weight,
      :weight_unit,
      :display_email,
      :display_phone,
      :show_facebook,
      :facebook_url,
      :show_website,
      :website_url,
      :show_linkedin,
      :linkedin_url,
      :show_pinterest,
      :pinterest_url,
      :about,
      :years_of_massage_experience,
      :certifications,
      :additional_services,
      :service_details,
      :work_location_radius,
      :work_location_radius_zip,
      :accepted_customers,
      :services_details,
      :created_at,
      :updated_at,
      :build_id,
      :body_hair_id,
      :hair_color_id,
      :eye_color_id,
      :sexual_orientation_id,
      :smoking_frequency_id,
      :drug_frequency_id,
      :ethnicity_id,
      :service_ids => [],
      :massage_technique_ids => [],
      :massage_product_ids => [],
      :massage_type_ids => [],
      :language_ids => [],
      :work_location_ids => [],
      :work_surface_ids => [],
      :client_type_ids => []     
    )
  end
end
