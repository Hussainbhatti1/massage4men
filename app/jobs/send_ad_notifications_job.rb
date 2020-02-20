class SendAdNotificationsJob < ActiveJob::Base
  queue_as :default

  def perform(ad)
    # Pull Clients who receive updates within NEARBY_SEARCH_RADIUS of the ad 
    clients = Client.within(NEARBY_SEARCH_RADIUS, origin: ad.masseur.masseur_detail)
                    .where(email_new_masseurs: true)

    # Queue up mails to go to them
    clients.each do |client|
      AdMailer.client_notification(client, ad).deliver_later
    end
  end
end
