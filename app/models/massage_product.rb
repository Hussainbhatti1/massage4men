class MassageProduct < ActiveRecord::Base
  has_and_belongs_to_many :masseur_details
end
