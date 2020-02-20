class ContactForm < MailForm::Base
  attribute :name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :account_type
  attribute :account_id
  attribute :message

  append :remote_ip, :user_agent


  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    admin_emails = SiteSetting.first.admin_notification_email
    
    {
      :subject => '[M4M] Contact Form Submission',
      :to => admin_emails,
      :from => %("#{name}" <#{email}>)
    }
  end
end