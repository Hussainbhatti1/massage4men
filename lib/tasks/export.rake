namespace :export do
  desc "Prints data in a seeds.rb way."
  task :seeds_format => [:environment] do
      ENV['MODELS'].split(',').each do |model_name|
      puts "\n# #{model_name.pluralize.upcase}"
      
      Object.const_get(model_name).order(:id).all.each do |model|
        puts "#{model_name}.create(#{model.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
      end      
    end
  end
end