class SendWeeklyDigestJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Send the update to clients who have been members for at least six days
    # Don't do it on any day other than Sunday
    if Time.now.strftime('%A') == 'Sunday'
      clients = Client.where('email_weekly_update = true AND created_at <= ?', 6.days.ago)
    
      clients.each do |client|
        # Fetch new, local masseurs that have approved ads
        masseurs = MasseurDetail.joins(:masseur).where('masseurs.created_at <= ? AND masseurs.approved = true', 6.days.ago).within(NEARBY_SEARCH_RADIUS, origin: client)
      
        # Convert to array and delete masseurs without ads
        masseurs.reject_if { |m| !m.masseur.has_approved_ads? }
            
        # If there are any left, send the mail
        if masseurs.count > 0
          ClientMailer.weekly_masseur_digest(client, masseurs).deliver_later
        end
      end      
    end
  end
end
