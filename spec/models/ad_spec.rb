require 'rails_helper'

RSpec.describe Ad, type: :model do
  describe 'Instance Methods' do
    it 'correctly reports itself as a regular ad' do
      ad = FactoryGirl.build_stubbed(:ad)
      
      expect(ad.travel_ad?).to be_falsy
    end
    
    # it 'reports its latitude' do
    #   settings = FactoryGirl.create(:site_setting)
    # end
  end
  
  it 'does not save if masseur has max number of ads for his account type'  
  it 'returns correct screen name'
  it 'returns correct age'
end
