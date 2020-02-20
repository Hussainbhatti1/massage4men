class SharedDevise::PasswordsController < Devise::PasswordsController
  respond_to :json
  
  def new
    super
    render layout: false
  end
  
  def create
    if params[:client][:email].empty?
      return_failure('Please specify an email address')
    else
      # Check for a Client first
      client = Client.find_by('lower(email) = ?', params[:client][:email].downcase)

      if client
        resource_class = client
        # return_success
      else
        masseur = Masseur.find_by('lower(email) = ?', params[:client][:email].downcase)
        
        if masseur
          resource_class = masseur  
        end
      end
      
      # Send the email
      if resource_class
        resource_class.send_reset_password_instructions
        return_success
      else
        return_failure('Double-check your email and try again.')
      end
    end
  end
  
  private
  
  def return_success
    return render json: {success: true}
  end  
  
  def return_failure(error_msg)
    return render json: {success: false, error: error_msg}
  end
end
