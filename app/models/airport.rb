class Airport < ActiveRecord::Base
	geocoded_by :code
  	after_validation :geocode
end
