require 'rails_helper'

RSpec.describe Subscription, type: :model do
  it 'returns the last transaction'
  
  it 'returns nil if no transactions' do
    subscription = FactoryGirl.build_stubbed(:subscription)
    expect(subscription.last_transaction).to be_nil
  end
  
  it 'returns the last renewal'
  
  it 'returns false if never renewed' do
    subscription = FactoryGirl.build_stubbed(:subscription)
    expect(subscription.last_renewal).to be_falsy
  end
  
  it 'calculates the promo amount when it has a promo code' do
    settings = FactoryGirl.create(:site_setting, basic_package_price: 49, premium_package_price: 79)
    
    # Create a promo code with a 50% basic discount and 75% premium discount
    promo_code = FactoryGirl.build_stubbed(:promo_code, basic_discount_percentage: 50, premium_discount_percentage: 75)
    
    basic_subscription = FactoryGirl.build_stubbed(:subscription, promo_code: promo_code)
    
    # Basic subscription promo amount should be 49 - (49 * .50) = 24.50
    expect(basic_subscription.promo_amount).to eql(24.50)
    expect(basic_subscription.promo_amount_in_cents).to eql(2450)
    
    premium_subscription = FactoryGirl.build_stubbed(:subscription, :premium, promo_code: promo_code)
    
    # Premium subscription promo amount should be 79 - (79 * .75) = 19.75
    expect(premium_subscription.promo_amount).to eql(19.75)
    expect(premium_subscription.promo_amount_in_cents).to eql(1975)
  end
  
  it 'returns the full amount when it does not have a promo code' do
    settings = FactoryGirl.create(:site_setting)
    
    subscription = FactoryGirl.build_stubbed(:subscription)
    expect(subscription.promo_amount).to eql(subscription.full_amount)
  end
  
  it 'returns the full amount when it has an inactive promo code' do
    settings = FactoryGirl.create(:site_setting)
    
    subscription = FactoryGirl.build_stubbed(:subscription, :with_promo_code)
    subscription.promo_code.active = false
    
    expect(subscription.promo_amount).to eql(subscription.full_amount)
  end
  
  it 'returns the correct full amount based on the subscription_type' do
    settings = FactoryGirl.create(:site_setting, basic_package_price: 49, premium_package_price: 79)
    
    subscription = FactoryGirl.build_stubbed(:subscription)
    expect(subscription.full_amount).to eql(49.0)
    expect(subscription.full_amount_in_cents).to eql(4900)
    
    premium_subscription = FactoryGirl.build_stubbed(:subscription, :premium)
    expect(premium_subscription.full_amount).to eql(79.0)
    expect(premium_subscription.full_amount_in_cents).to eql(7900)
  end  
end
