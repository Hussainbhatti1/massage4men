class ClientMailer < ApplicationMailer
  def welcome_message(client)
    @client = client
    
    mail(
      to: @client.email,
      subject: 'Welcome to Massage4Men!'
    )
  end

  def notify_admin_for_approval_email(client)
    @client = client
    @admin_emails = SiteSetting.first.admin_notification_email ? SiteSetting.first.admin_notification_email : ADMIN_EMAIL

    mail(to: @admin_emails, subject: "[M4M] Approval Required for New Client Account")
  end

  def weekly_masseur_digest(client, masseurs)
    @client = client
    @masseurs = masseurs
    ordinalized_day = Date.today.beginning_of_week.strftime('%-d').to_i.ordinalize
    
    mail(
      to: @client.email,
      subject: "Your Massage4Men update for the week of #{Date.today.beginning_of_week.strftime('%B')} #{ordinalized_day}"
    )
  end
end
