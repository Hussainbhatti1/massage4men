require 'rails_helper'

RSpec.describe TravelAd, type: :model do
  describe 'Validations' do
    it 'fails validation if user has too many travel ads' do
      settings = FactoryGirl.create(:site_setting)
      masseur = FactoryGirl.create(:masseur)
    
      basic_subscription = FactoryGirl.create(:subscription, masseur: masseur)
    
      # Basic subscriptions can have one travel ad
      travel_ad = FactoryGirl.create(:travel_ad, masseur: masseur)
    
      expect(travel_ad.valid?).to be_truthy
      expect(travel_ad.persisted?).to be_truthy
    
      travel_ad_2 = FactoryGirl.build_stubbed(:travel_ad, masseur: masseur)
    
      expect(travel_ad_2.valid?).to be_falsy
          
      # Premium subscriptions can have six travel ads
      premium_masseur = FactoryGirl.create(:masseur)
      premium_subscription = FactoryGirl.create(:subscription, :premium, masseur: premium_masseur)
    
      1.upto(PREMIUM_TRAVEL_AD_LIMIT) do |n|
        ad = FactoryGirl.create(:travel_ad, masseur: premium_masseur)
        expect(ad.persisted?).to be_truthy
      end
    
      final_ad = FactoryGirl.build_stubbed(:travel_ad, masseur: premium_masseur)
      expect(final_ad.valid?).to be_falsy
    end
  end
  
  describe 'Instance Methods' do
    it 'reports itself as a travel ad' do
      expect(FactoryGirl.build_stubbed(:travel_ad).travel_ad?).to be_truthy
    end
    
    it 'assembles a correct location string' do
      ad = FactoryGirl.build_stubbed(:travel_ad, city: 'Chicago', state: nil, country: nil)
      
      expect(ad.location_string).to eql('Chicago')
      
      ad.state = 'IL'
      
      expect(ad.location_string).to eql('Chicago, IL')
      
      ad.country = 'USA'
      
      expect(ad.location_string).to eql('Chicago, IL')
      expect(ad.location_string(include_country = true)).to eql('Chicago, IL USA')
    end
  end
  
  describe 'Callbacks' do
    it 'fetches and parses a geocode when created' do
      settings = FactoryGirl.create(:site_setting)
      
      masseur = FactoryGirl.create(:masseur)
      basic_subscription = FactoryGirl.create(:subscription, masseur: masseur)

      ad = FactoryGirl.create(:travel_ad, masseur: masseur, city: 'Chicago', state: 'IL', country: 'USA')
      
      # => 41.8781136
      # => -87.6297982      
      expect(ad.lat).to eql(41.8781136)
      expect(ad.lng).to eql(-87.6297982)
    end
  end
end
