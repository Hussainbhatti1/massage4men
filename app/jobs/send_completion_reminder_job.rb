class SendCompletionReminderJob < ActiveJob::Base
  queue_as :default

  def perform(masseur)
    # Check `masseur` profile for completeness.
    # If less than 100% complete, send him a reminder to finish.
    @masseur = masseur
    @completion = masseur.calculate_completeness
    
    if @completion[:percentage] < 100
      # Send him an email.
      MasseurMailer.completion_reminder(@masseur, @completion).deliver_now
      
      # Schedule another reminder in 5 days.
      # The job will check if he's complete before sending.
      SendCompletionReminderJob.set(wait: 5.days).perform_later(@masseur)
    end
  end
end
