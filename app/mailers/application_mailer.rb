class ApplicationMailer < ActionMailer::Base
  default from: "Massage4Men <noreply@m4m.net>"
  layout 'mailer'

  helper :application, :'admin/emails'
  
  def system_email(user, email)
    # Accept a Client/Masseur object and an Email object
    @user = user
    @email = email
    
    mail(to: @user.email, subject: @email.subject)
  end
end
