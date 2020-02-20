module Geokit
  module IpGeocodeLookup
    def get_ip_address
      if defined? TEST_IP
        TEST_IP
      else
        request.remote_ip
      end
    end    
  end
end