FactoryGirl.define do
  factory :subscription do
    masseur
    
    subscription_type SUBSCRIPTION_BASIC
    active            true
    
    # Fixed "relation does not exist" with this: http://stackoverflow.com/a/28058295
    trait :with_promo_code do
      promo_code      { FactoryGirl.build_stubbed(:promo_code) }
    end      
    
    trait :premium do
      subscription_type SUBSCRIPTION_PREMIUM
    end
    
    trait :inactive do
      active            false
    end
  end
end
