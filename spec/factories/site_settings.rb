FactoryGirl.define do
  factory :site_setting do
    basic_package_price   39.0
    premium_package_price 79.0
    
    approval_required_for_new_masseurs  [true, false].sample
    
    payment_address "#{Faker::Address.street_address}, #{Faker::Address.city}, #{Faker::Address.state_abbr} #{Faker::Address.zip}"
    admin_notification_email  'tim@atomicpromise.com,test_admin@example.com'
    keywords  Faker::Hipster.words(4).join(', ')
    badge_disclaimer Faker::Hipster.paragraphs(1)
  end
end
