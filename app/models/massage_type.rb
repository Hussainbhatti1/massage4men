class MassageType < ActiveRecord::Base
  has_and_belongs_to_many :masseur_details
  has_many :ads
  
  def allows_adult_photos?
    self.name != 'Therapeutic'
  end
end
