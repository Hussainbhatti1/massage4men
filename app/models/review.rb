class Review < ActiveRecord::Base
  belongs_to :client
  belongs_to :masseur

  validates :client,
            :masseur,
            :review,
            :masseur_on_time,
            :service_as_requested,
            presence: true
  
  validates :rating,
            :masseur_appearance,
            :masseur_personality,
            :likelihood_to_rebook,
            :likelihood_to_refer,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0,
              less_than_or_equal_to: 5
            }

  validates :masseur_on_time,
            :service_as_requested,
            inclusion: {
              in: ['Yes', 'No']
            }
  
  after_create :notify_masseur
  
  scope :approved, -> { where('admin_approved = true OR masseur_approved = true') }
  
  def notify_masseur
    MasseurMailer.notify_masseur_of_new_review_email(self).deliver_now
  end
end
