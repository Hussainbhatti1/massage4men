class PostAdsReminderJob < ActiveJob::Base
  queue_as :default

  def perform(masseur)
    @masseur = masseur
    
    if @masseur.ads.count < 1
      MasseurMailer.post_add_reminder(@masseur).deliver_now
      
      # Schedule another reminder in 5 days.
      # The job will check if he's added any ads before sending.
      PostAdsReminderJob.set(wait: 5.days).perform_later(@masseur)
    end
  end
end
