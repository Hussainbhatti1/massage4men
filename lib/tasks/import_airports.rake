namespace :import do
  desc "Imports airport data from openflights.org"
  
  task :airports => :environment do
    require 'open-uri'
    require 'csv'
    
    DATA_URL = 'https://raw.githubusercontent.com/jpatokal/openflights/master/data/airports.dat'
    
    airport_count_start = Airport.count
    
    puts 'Downloading airport database...'
    CSV.new(open(DATA_URL)).each do |line|
      if(line[3] == 'United States')
        Airport.where(code: line[4]).first_or_create do |airport|
          airport.name = line[1]
          airport.code = line[4]
          airport.latitude = line[6]
          airport.longitude = line[7]
        end
      end
    end
    
    puts "Done! Start count: #{airport_count_start.to_s} ---- End count: #{Airport.count.to_s}"    
  end
end