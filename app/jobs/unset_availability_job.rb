class UnsetAvailabilityJob < ActiveJob::Base
  queue_as :default

  def perform(masseur, duration)
    # Unset availability if the masseur hasn't unset it already
    if masseur.available?
      masseur.available = false
      masseur.save!

      if masseur.notify_when_availability_expires
        MasseurMailer.unset_availability_success_email(masseur, duration).deliver_now
      end
    end
  end
end
