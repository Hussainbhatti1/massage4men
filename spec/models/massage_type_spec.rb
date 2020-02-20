require 'rails_helper'

RSpec.describe MassageType, type: :model do
  it 'does not allow adult photos in therapeutic ads' do
    massage_type = FactoryGirl.build_stubbed(:massage_type, name: 'Therapeutic')    
    expect(massage_type.allows_adult_photos?).to be_falsy
  end
  
  it 'allows adult photos in sensual ads' do
    massage_type = FactoryGirl.build_stubbed(:massage_type, name: 'Sensual')
    expect(massage_type.allows_adult_photos?).to be_truthy    
  end
  
  it 'allows adult photos in customized ads' do
    massage_type = FactoryGirl.build_stubbed(:massage_type, name: 'Customized')
    expect(massage_type.allows_adult_photos?).to be_truthy        
  end
end
