class Admin::EmailsController < Admin::BaseController
  layout :choose_layout  ,except: [:send_email]
  
  load_and_authorize_resource
  
  def index
    
  end
  
  def new
    
  end
  
  def edit
    
  end
  
  def show
    # Randomly determine a Client or Masseur to use for the sample
    if rand(1337).even?
      @demo_user = Masseur.all.sample
    else
      @demo_user = Client.all.sample
    end
  end
  
  def create
    if @email.save
      redirect_to admin_emails_path, notice: 'Email created.'
    else
      render :edit
    end
  end
  
  def update
    if @email.update_attributes(email_params)
      redirect_to admin_emails_path, notice: 'Email saved.'
    else
      render :edit
    end
  end
  
  def destroy
    old_subject = @email.subject
    
    if @email.destroy
      flash['notice'] = "Email &ldquo;#{old_subject}&rdquo; deleted."
    else
      flash['error'] = 'Email could not be deleted.'
    end
    
    redirect_to :back
  end


  def send_email
    emails = params[:email_id].split(",")

    emails.each do |email|
      AdminMailer.system_email(email, params[:subject], params[:body]).deliver
    end
    
    respond_to do |format|
      format.json { head :no_content }
    end 
  end

  
  private
  def email_params
    params.require(:email).permit(:subject, :body)
  end
  
  def choose_layout
    case action_name
    when 'show'
      'mailer'
    else
      'admin'
    end
  end
end
