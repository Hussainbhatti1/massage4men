namespace :move do
  task :about_fields => :environment do
    desc 'Move "About My Services" and "About Me" from a Masseur record to all of his ads'
    
    Masseur.find_each do |masseur|
      masseur.ads.each do |ad|
        ad.update_attributes(
                              about_me: masseur.masseur_detail.about,
                              about_my_services: masseur.masseur_detail.services_details)
      end
    end
  end
end