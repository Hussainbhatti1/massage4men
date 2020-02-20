FactoryGirl.define do
  # sequence :email do |n|
  #   "email#{n}@atomicpromise.com"
  # end

  factory :masseur do
    email                 Faker::Internet.email

    dob                   Faker::Date.between(50.years.ago, 18.years.ago)
    password              'p4ssw0rD!'
    password_confirmation 'p4ssw0rD!'
    
    screen_name           Faker::Internet.user_name
    profile_photo         { File.new(Rails.root.join('app', 'assets', 'images', 'logo-m4m.png')) }
    
    trait :complete do
      first_name          Faker::Name.first_name
      last_name           Faker::Name.last_name
      screen_name         Faker::App.name.downcase
      mailing_address     Faker::Address.street_address
      mailing_city        Faker::Address.city
      mailing_state       Faker::Address.state_abbr
      mailing_zip         Faker::Address.zip
      
      contact_phone       Faker::PhoneNumber.phone_number
      contact_phone_type  ['Mobile', 'Landline'].sample
    
      provides_services_at_mailing_address  Faker::Boolean.boolean
    end
  end
end
