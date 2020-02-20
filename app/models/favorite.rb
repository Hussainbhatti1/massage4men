class Favorite < ActiveRecord::Base
  belongs_to :client
  belongs_to :masseur
end
