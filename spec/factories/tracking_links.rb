FactoryGirl.define do
  factory :tracking_link do
    # code is automatically generated after create
    source ['SMS', 'Email', 'TV', 'Magazine'].sample
  end
end
