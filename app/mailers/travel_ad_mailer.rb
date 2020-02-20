class TravelAdMailer < ApplicationMailer
  helper :travel_ads
  
  def client_notification(client, travel_ad)
    @client = client
    @travel_ad = travel_ad
    @masseur = @travel_ad.masseur
    
    mail( to: @client.email,
          subject: "A new masseur is traveling to #{@travel_ad.city}!")
  end
end
