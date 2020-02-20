class CreateMasseurDetails < ActiveRecord::Migration
  def change
    create_table :masseur_details do |t|
      # All extended details for Masseur accounts: See spec p.6
      # 1. Mailing Address
      # All address info is stored ON the user model since Client and Masseur accounts both need these fields
      t.boolean :provides_services_at_user_address
      
      # DOB, contact phone, phone type, private email are also on user model
      
      # 2. "About You" section info
      t.string  :screen_name
      t.boolean :display_real_age
      t.integer :display_age
      t.string  :home_base_city
      t.string  :home_base_state
      t.string  :home_base_zip
      t.string  :home_base_country
      
      # 2a. Demographics
      t.integer :height
      t.integer :height_unit
      t.integer :weight
      t.integer :weight_unit
      
      # Build, body type, etc...see below.
      
      t.string :display_email
      t.string :display_phone
      
      t.boolean :show_facebook
      t.string  :facebook_url
      
      t.boolean :show_website
      t.string  :website_url
      
      t.boolean :show_linkedin
      t.string  :linkedin_url
      
      t.boolean :show_pinterest
      t.string  :pinterest_url
      
      t.text    :about
      
      t.integer :years_of_massage_experience
      
      t.text    :certifications
      t.text    :additional_services
      
      t.string  :work_surface # "How do you work? (table/floor/mat/bed/other)"
      
      # "Where do you work?"
      t.integer :work_location  # 0 - my place, 1 - your place
      t.integer :work_location_radius
      t.string  :work_location_radius_zip
      
      t.string  :accepted_customers # "Who do you serve?"
      t.text    :services_details
      
      # Put all association keys at the END of the table.
      # Until we create these models...
      # t.references :build
      # t.references :hair_color
      # t.references :body_hair
      # t.references :eye_color
      # t.references :sexual_orientation
      # t.references :smoking_frequency
      # t.references :drug_frequency
      # t.references :ethnicity
      # t.references :language
      # Offerings?

      t.timestamps null: false
    end
  end
end
