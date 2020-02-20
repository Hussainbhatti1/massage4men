# seed-ads-and-ad-photos.rb

# Generate ads for BASIC masseurs first
# 80% should have both ads
# 20% should have one ad

def assign_random_photos_to_ad(ad)
  # Basic advertisers get up to 4 SFW images
  ad.photos = ad.masseur.photos.order_by_rand.where(adult: false).limit(Random.rand(1..4))
  
  if ad.save
    puts '-- Ad and photos saved.'
  else
    puts '!- AD PHOTOS FAILED TO SAVE'
  end
end

Subscription.where(active: true, subscription_type: SUBSCRIPTION_BASIC).each do |sub|
  m = sub.masseur
  
  if m.ads.count == 0
    x = Random.rand(100)
  
    if x < 80
      # 80% should have both ads
      ad_types = MassageType.order_by_rand.limit(2)
    
      ad_types.each do |t|
        ad = m.ads.build(massage_type: t)
      
        if ad.save
          assign_random_photos_to_ad(ad)
        else
          puts "- Ad failed to save!"
          puts ad.errors.inspect
        end      
      end    
    else
      # 20% should have one ad
      ad_type = MassageType.order_by_rand.first
    
      ad = m.ads.build(massage_type: ad_type)
      
      if ad.save
        assign_random_photos_to_ad(ad)
      else
        puts '- Ad failed to save!'
        puts ad.errors.inspect
      end
    
    end
  else
    puts "- Masseur already has ads. Skipping..."
  end
end