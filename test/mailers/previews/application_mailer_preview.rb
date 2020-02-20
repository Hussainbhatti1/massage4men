class ApplicationMailerPreview < ActionMailer::Preview
  def system_email
    ApplicationMailer.system_email(Client.first, Email.last)
  end  
end
