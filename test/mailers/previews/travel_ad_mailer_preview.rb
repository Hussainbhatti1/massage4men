# Preview all emails at http://localhost:3000/rails/mailers/subscription_mailer
class TravelAdMailerPreview < ActionMailer::Preview
  def client_notification
    TravelAdMailer.client_notification(Client.last, TravelAd.first)
  end
end
