FactoryGirl.define do
  sequence :code do |n|
    "PROMO#{n}"
  end
  
  factory :promo_code do
    code
    description    Faker::Hipster.sentence
    length_in_days { rand(1..90) }
    
    start_date     30.days.ago
    end_date       30.days.from_now
    
    trait :expired do
      end_date     5.days.ago
    end
    
    trait :total_discount do
      basic_discount_percentage   100
      premium_discount_percentage 100
    end
    
    trait :partial_discount do
      basic_discount_percentage   50
      premium_discount_percentage 75      
    end
    
    active  true

    trait :inactive do
      active  false
    end    
  end
end
