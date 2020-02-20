class AdMailerPreview < ActionMailer::Preview
  def client_notification
    AdMailer.client_notification(Client.last, Ad.first)
  end
end
