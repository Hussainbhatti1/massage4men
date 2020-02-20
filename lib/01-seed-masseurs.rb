require 'open-uri'

TOTAL_TO_ADD = 10

# Import masseurs from JSON
puts "Getting mock data for #{TOTAL_TO_ADD.to_s} masseurs..."
list = JSON.parse(HTTParty.get("https://www.mockaroo.com/89823160/download?count=#{TOTAL_TO_ADD}&key=89642d40").body)

# Generate random possible photo sizes
random_sizes = [
  {width: 640, height: 480},
  {width: 350, height: 350},
  {width: 960, height: 1280},
  {width: 1280, height: 960}
]

list.each_with_index do |u, i|
  puts "(#{(i + 1).to_s}/#{TOTAL_TO_ADD.to_s}) Creating masseur..."
  m = Masseur.new(u)
  m.email = 'tim+masseur' + i.to_s + '@timspangler.com'
  
  # Get a robohash avatar of a random size
  size = random_sizes[Random.new(Time.now.nsec).rand(3)]
  
  puts "- Getting RoboHash image at size #{size[:width].to_s}x#{size[:height].to_s}"
  
  m.profile_photo = open("https://robohash.org/#{u['email']}?size=#{size[:width].to_s}x#{size[:height].to_s}")
  
  puts "- Saving..."
  
  if m.save
    puts "- SAVE OK. "
  else
    puts "-! SAVE FAILED."
    puts m.errors.inspect
  end
end