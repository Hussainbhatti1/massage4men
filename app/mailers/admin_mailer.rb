class AdminMailer < ApplicationMailer
  before_action :get_admin_emails
  
  def postback_subscription_not_found(post_params)
    @post_params = post_params
    mail( to: @admin_emails,
          subject: '[M4M.net] Renewal failure: Subscription not found')    
  end
  
  def notify_admin_of_rejected_review(review)
    @review = review
    @masseur = review.masseur
    @client = review.client
    mail(to: @admin_emails, subject: "[M4M] #{@masseur.screen_name} rejected a review.")
  end
  
  def new_client_signup(client)
    @client = client
    mail(to: @admin_emails, subject: '[M4M] New Client Signup')
  end

  def system_email(email, subject, body)
    @user = Masseur.where(email: email).first
    @email = email
    @subject = subject
    @body = body
    mail(to: @email ,subject: @subject)
  end

  private
  def get_admin_emails
    @admin_emails = SiteSetting.first.admin_notification_email ? SiteSetting.first.admin_notification_email : ADMIN_EMAIL    
  end
end
