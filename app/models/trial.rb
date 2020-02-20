class Trial < ActiveRecord::Base
  belongs_to :masseur
  belongs_to :promo_code
end
