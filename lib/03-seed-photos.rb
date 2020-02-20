require 'open-uri'
# Seed the Photo model with random photos from lorempixel
# http://lorempixel.com/400/200
# http://lorempixel.com/g/400/200

MIN_PHOTOS_PER_MASSEUR = 3
MAX_PHOTOS_PER_MASSEUR = 10

random_sizes = [
  {width: 640, height: 480},
  {width: 350, height: 350},
  {width: 960, height: 1280},
  {width: 1280, height: 960}
]

# Pull Masseurs without any photos
Masseur.includes(:photos).where(photos: { masseur_id: nil }).each_with_index do |m, i|
  photo_count = Random.rand(MIN_PHOTOS_PER_MASSEUR..MAX_PHOTOS_PER_MASSEUR)
  
  1.upto(photo_count) do |n|
    puts "Masseur #{(i + 1).to_s} / #{Masseur.count.to_s} - Photo #{n.to_s} of #{photo_count.to_s}..."
    
    # Lorem Pixel stuff
    size = random_sizes.sample 
    lorem_pixel_url = "http://lorempixel.com/"
  
    if (Random.rand(1..100) >= 90)
      lorem_pixel_url += '/g/'
    end
  
    lorem_pixel_url += "#{size[:width]}/#{size[:height]}"
    
    puts "URL: #{lorem_pixel_url}"

    p = m.photos.build(approved: true, adult: false)
  
    p.picture = open(lorem_pixel_url)

    if p.save
      puts "- Save OK!"
    else
      puts "- Save FAILED"
      puts p.errors.inspect
    end
  end
end