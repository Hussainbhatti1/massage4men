# Seed everything else!

# First, services. 1-6, HABTM
puts 'Hold onto your butts...'
puts 'Mocking Services...'
ALL_SERVICES = (1..Service.count).to_a

# Get all MasseurDetails without any services
MasseurDetail.includes(:services).where(:masseur_details_services => { :masseur_detail_id => nil }).each do |d|
  d.service_ids = (ALL_SERVICES.sample Random.rand(1..Service.count)).sort
end

puts 'Mocking MassageTechniques...'
ALL_TECHNIQUES = (1..MassageTechnique.count).to_a

MasseurDetail.includes(:massage_techniques).where(:massage_techniques_masseur_details => { :masseur_detail_id => nil }).each do |d|
  d.massage_technique_ids = (ALL_TECHNIQUES.sample Random.rand(1..MassageTechnique.count)).sort
end

puts 'Mocking MassageProducts...'
ALL_PRODUCTS = (1..MassageProduct.count).to_a

MasseurDetail.includes(:massage_products).where(:massage_products_masseur_details => { :masseur_detail_id => nil }).each do |d|
  d.massage_product_ids = (ALL_PRODUCTS.sample Random.rand(1..MassageProduct.count)).sort
end

puts 'Mocking MassageTypes...'
ALL_TYPES = (1..MassageType.count).to_a

MasseurDetail.includes(:massage_types).where(:massage_types_masseur_details => { :masseur_detail_id => nil }).each do |d|
  d.massage_type_ids = (ALL_TYPES.sample Random.rand(1..MassageType.count)).sort
end

puts 'Mocking MasseurLanguages...'
ALL_LANGUAGES = (1..Language.count).to_a

MasseurDetail.includes(:languages).where(:masseur_languages => { :masseur_detail_id => nil }).each do |d|
  d.language_ids = (ALL_LANGUAGES.sample Random.rand(1..Language.count)).sort
end

puts 'Mocking Rates...'
MasseurDetail.includes(:rates).where(:rates => { :masseur_detail_id => nil }).each do |d|
  # How many Incall rates should we generate?
  incall_number = Random.rand(0..5)
  
  if incall_number > 0
    1.upto(incall_number) do |num|
      r = d.rates.build(rate_type: RATE_INCALL)
      
      rate_floor = num * 25
      rate_ceiling = rate_floor + 25
      
      r.rate = Random.rand(rate_floor..rate_ceiling)
      r.time = "#{(num * 15).to_s} minutes"
      r.description = 'Automatically generated'
      
      if !r.save
        puts '-! RATE SAVING ERROR:'
        puts r.errors.inspect
      end
    end
  end  
  
  # How many Outcall rates should we generate?
  outcall_number = Random.rand(0..5)
  
  if outcall_number > 0
    1.upto(outcall_number) do |num|
      r = d.rates.build(rate_type: RATE_OUTCALL)
    
      # Outcall is more expensive
      rate_floor = num * 50
      rate_ceiling = rate_floor + 50
    
      r.rate = Random.rand(rate_floor..rate_ceiling)
      r.time = "#{(num * 15).to_s} minutes"
      r.description = 'Automatically generated'
    
      if !r.save
        puts '-! RATE SAVING ERROR:'
        puts r.errors.inspect
      end      
    end
  end
end