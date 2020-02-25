class MasseurMailer < ApplicationMailer
  def badge_approved_email(masseur, badge_type, badge_code)
    @masseur = masseur
    @badge_type = badge_type
    @badge_code = badge_code
    mail(to: @masseur.email, subject: "[M4M] Your #{@badge_type.titleize} badge has been approved.")
  end

  def notify_admin_for_approval_email(masseur)
    @masseur = masseur
    @admin_emails = SiteSetting.first.admin_notification_email ? SiteSetting.first.admin_notification_email : ADMIN_EMAIL

    mail(to: @admin_emails, subject: "[M4M] Approval Required for New Masseur Account")
  end
  
  def notify_masseur_of_new_review_email(review)
    @masseur = review.masseur
    @client = review.client
    @review = review
    
    mail(to: @masseur.email, subject: "#{@client.screen_name} reviewed you on M4M.net")
  end

  def welcome_email(masseur)
    @masseur = masseur
    
    mail(
      to: @masseur.email,
      subject: "#{@masseur.first_name}, welcome to Massage4Men!"
    )
  end
    
  def unset_availability_success_email(masseur, duration)
    @masseur = masseur
    @duration = duration
    
    mail(to: @masseur.email, subject: '[M4M] Your availability has expired.')
  end
  
  def one_week_rebill_notice_email(masseur)
    @masseur = masseur
    
    mail(to: @masseur.email, subject: 'Your M4M.net subscription will renew in one week.')
  end
  
  def day_of_rebill_notice_email(masseur)
    @masseur = masseur
    
    mail(to: @masseur.email, subject: 'Your M4M.net subscription will renew today.')
  end  
  
  def completion_reminder(masseur, completion)
    @masseur = masseur
    @completion = completion
    
    if @masseur.screen_name
      subj = "#{@masseur.screen_name}, complete your M4M.net profile today!"
    else
      subj = 'Complete your M4M.net profile today!'
    end
    
    mail(to: @masseur.email, subject: subj)
  end
end
