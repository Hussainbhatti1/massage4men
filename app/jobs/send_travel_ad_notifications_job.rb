class SendTravelAdNotificationsJob < ActiveJob::Base
  queue_as :default

  def perform(travel_ad)
    # Pull Clients who receive updates within NEARBY_SEARCH_RADIUS of the ad 
    clients = Client.within(NEARBY_SEARCH_RADIUS, origin: travel_ad)
                    .where(email_new_masseurs: true)

    # Queue up mails to go to them
    clients.each do |client|
      TravelAdMailer.client_notification(client, travel_ad).deliver_later
    end
  end
end
