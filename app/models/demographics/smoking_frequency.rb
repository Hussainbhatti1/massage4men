class SmokingFrequency < ActiveRecord::Base
  has_many :masseur_details

  def name
    self.frequency
  end
end
