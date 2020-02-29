class Admin::MasseurDocumentationsController < Admin::BaseController
  load_and_authorize_resource :masseur
  load_and_authorize_resource :masseur_documentation

  before_action :validate_and_load_doc_type
  
  def index
    @unapproved = @masseur_documentations.where('
      (certification_submitted IS NOT NULL AND certification_approved = false)
      OR
      (license_submitted IS NOT NULL AND license_approved = false)      
      OR
      (photo_id_submitted IS NOT NULL AND photo_id_approved = false)')
  end
  
  def approve
    if @doc_type == 'certification'
      badge_name = 'Certified Therapist'
      badge_type = 'certified'
    elsif @doc_type == 'license'
      badge_name = 'Licensed Therapist'
      badge_type = 'licensed'
    elsif @doc_type == 'photo_id'
      badge_name = 'Verified Therapist'
      badge_type = 'verified'
    else
      badge_name = 'Unknown Badge'
      badge_type = 'unknown'
    end
    
    respond_to do |format|
      if @masseur_documentation.update_attributes("#{@doc_type}_approved": true)
        MasseurMailer.badge_approved_email(@masseur, badge_name, badge_type).deliver_now
        format.js { }
        format.html { redirect_to :back, notice: "#{@doc_type.titleize} approved." }
      else
        format.js { render json: {success: false}, status: :unprocessable_entity }
        format.html { redirect_to :back, error: "Error approving #{@doc_type.titleize}." }
      end
    end
  end
  
  def deny
    # Unset approval information and detach file.
    respond_to do |format|
      if @masseur_documentation.update_attributes("#{@doc_type}_approved": nil,
                                                  "#{@doc_type}_submitted": nil,
                                                  "#{@doc_type}": nil)

        format.js { }
        format.html { redirect_to :back, notice: "#{@doc_type.titleize} denied." }
      else
        format.js { render json: {success: false}, status: :unprocessable_entity}
        format.html { redirect_to :back, error: "Error denying #{@doc_type.titleize}" }
      end
    end
  end
  
  private
  def validate_and_load_doc_type
    return if !['certification', 'license', 'photo_id'].include? params[:doc]
    
    @doc_type = params[:doc]
  end
end
