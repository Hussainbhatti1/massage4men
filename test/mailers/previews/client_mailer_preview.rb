# Preview all emails at http://localhost:3000/rails/mailers/client_mailer
class ClientMailerPreview < ActionMailer::Preview
  def welcome_message
    ClientMailer.welcome_message(Client.first)
  end
  
  def weekly_masseur_digest
    ClientMailer.weekly_masseur_digest(Client.first, MasseurDetail.joins(:masseur).where(masseurs: {approved: true}))
  end
end
