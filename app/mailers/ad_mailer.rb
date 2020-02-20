class AdMailer < ApplicationMailer
  helper :ads
  
  def client_notification(client, ad)
    @client = client
    @ad = ad
    @masseur = @ad.masseur
    
    mail( to: @client.email,
          subject: "A new masseur just posted an ad near you.")
  end

end
