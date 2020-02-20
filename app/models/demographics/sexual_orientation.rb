class SexualOrientation < ActiveRecord::Base
  has_many :masseur_details

  def name
    self.orientation
  end
end
