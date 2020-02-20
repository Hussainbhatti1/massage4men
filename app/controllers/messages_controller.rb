class MessagesController < ApplicationController
  # before_action :authenticate_user!
  skip_authorization_check

  def new
    # Recipient is determined by client_id or masseur_id in GET
    if params[:masseur_id].nil? && params[:client_id].nil?
      render text: 'No recipient specified.'
    elsif params[:masseur_id].present? && params[:client_id].present?
      render text: 'Too many recipients specified.'
    elsif params[:masseur_id].present?
      @recipient_type = 'masseur'
      @recipient_id = params[:masseur_id]
      @recipient = Masseur.find(params[:masseur_id])
    elsif params[:client_id].present?
      @recipient_type = 'client'
      @recipient_id = params[:client_id]
      @recipient = Client.find(params[:client_id])
    end
    
    @client = Client.new
    
    render layout: false  
  end
  
  def create
    # Lookup the recipient
    respond_to do |format|
      if params[:message].nil?
        format.js { render json: {success: false, error: 'No parameters given.'}, status: :unprocessable_entity}
      else
        if params[:message][:recipient_type] == 'masseur'
          recipient = Masseur.find(params[:message][:recipient_id])
        elsif params[:message][:recipient_type] == 'client'
          recipient = Client.find(params[:message][:recipient_id])
        else
          format.js { render json: {success: false, error: 'Invalid recipient.'}, status: :unprocessable_entity}
        end      
      end
    
      # Now send the message
      conversation = current_user.send_message(recipient, params[:message][:body], params[:message][:subject])
    
      format.js { }
    end
  end
end
