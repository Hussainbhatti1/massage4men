FactoryGirl.define do
  factory :ad do
    masseur
    massage_type

    about_me          Faker::Lorem.paragraph
    about_my_services Faker::Lorem.paragraph
    
    # Photos are assigned in tests as needed
    
    # trait :approved do
    #   approved        true
    # end
  end
end
