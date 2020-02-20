class HairColor < ActiveRecord::Base
  has_many :masseur_details

  def name
    self.color
  end
end
