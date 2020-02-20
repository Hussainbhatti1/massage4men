FactoryGirl.define do
  factory :travel_ad do
    masseur
    massage_type
    about_me Faker::Hipster.paragraphs(2)
    about_my_services Faker::Hipster.paragraphs(2)
    city Faker::Address.city
    state Faker::Address.state_abbr
    country Faker::Address.country
  end
end
