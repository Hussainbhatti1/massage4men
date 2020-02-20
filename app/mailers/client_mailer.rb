class ClientMailer < ApplicationMailer
  def welcome_message(client)
    @client = client
    
    mail(
      to: @client.email,
      subject: 'Welcome to Massage4Men!'
    )
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
