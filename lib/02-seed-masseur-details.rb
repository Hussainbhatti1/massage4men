rows_needed = Masseur.count - MasseurDetail.count

# Import masseurs from JSON
puts "Getting mock data for #{rows_needed.to_s} masseurs..."
list = JSON.parse(HTTParty.get("https://www.mockaroo.com/1e3c4b20/download?count=#{rows_needed.to_s}&key=89642d40").body)

# Random columns: Build, BodyHair, HairColor, EyeColor, SexualOrientation, SmokingFrequency, DrugFrequency, Ethnicity

list.each_with_index do |d, i|
  # Find the first Masseur that needs details
  m = Masseur.includes(:masseur_detail).where(:masseur_details => { :masseur_id => nil }).first

  puts "(#{(i + 1).to_s}/#{rows_needed.to_s}) Setting mock MasseurDetail data for Masseur # #{m.id.to_s}..."

  details = m.build_masseur_detail(d)
  
  details.build = Build.order_by_rand.first
  details.body_hair = BodyHair.order_by_rand.first
  details.hair_color = HairColor.order_by_rand.first
  details.eye_color = EyeColor.order_by_rand.first
  details.smoking_frequency = SmokingFrequency.order_by_rand.first
  details.drug_frequency = DrugFrequency.order_by_rand.first
  details.sexual_orientation = SexualOrientation.order_by_rand.first
  details.ethnicity = Ethnicity.order_by_rand.first
  
  puts "- Saving..."

  if details.save
    puts "- SAVE OK"
  else
    puts "-! SAVE FAILED."
    puts details.errors.inspect
  end
  
  # Wait to avoid Google geocoder rate limits
  puts "- Waiting 1/2 sec..."
  sleep(0.5)
end