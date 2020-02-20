class MasseurDocumentationsController < ApplicationController
  load_and_authorize_resource :masseur
  load_and_authorize_resource :masseur_documentation, through: :masseur, singleton: true
  
  before_action :update_submitted_timestamps, only: [:create, :update]
  before_action :set_page_title
  
  def new
    
  end
  
  def edit
    render :new
  end
  
  def update    
    if @masseur_documentation.update_attributes(masseur_documentation_params)
      redirect_to :back, notice: 'Documentation submitted successfully. You will be notified when it is approved.'
    else
      render :edit
    end
  end
  
  def create
    @dox = @masseur.build_masseur_documentation(masseur_documentation_params)

    if @dox.save
      redirect_to edit_masseur_masseur_documentation_path(current_masseur), notice: 'Documentation submitted successfully. You will be notified when it is approved.'
    else
      render :new
    end
  end
  
  private
  def set_page_title
    @page_title = 'My Documentation'
  end
  
  def masseur_documentation_params
    params.require(:masseur_documentation).permit(:certification,
                                                  :license,
                                                  :photo_id,
                                                  :certification_notes,
                                                  :license_notes,
                                                  :photo_id_notes,
                                                  :certification_submitted,
                                                  :license_submitted,
                                                  :photo_id_submitted,
                                                  :certification_approved,
                                                  :license_approved,
                                                  :photo_id_approved)
  end
  
  def update_submitted_timestamps
    ['certification', 'license', 'photo_id'].each do |doc_type|
      # If user is uploading a given document, update the timestamp for it
      if params[:masseur_documentation][doc_type]
        params[:masseur_documentation]["#{doc_type}_submitted"] = Time.now
        params[:masseur_documentation]["#{doc_type}_approved"] = false
      end
    end
  end
end