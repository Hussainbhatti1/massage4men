FactoryGirl.define do
  factory :photo do
    # Photos are SFW and unapproved by default
    trait :adult do
      adult true
    end
    
    trait :approved do
      approved true
    end

    picture Faker::Avatar.image
  end
end
