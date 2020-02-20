class BodyHair < ActiveRecord::Base
  has_many :masseur_details

  def name
    self.hairiness
  end
end
