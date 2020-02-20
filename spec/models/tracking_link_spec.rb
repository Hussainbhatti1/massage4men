require 'rails_helper'

RSpec.describe TrackingLink, type: :model do
  it { should validate_uniqueness_of(:code) }
  
  it 'generates a code' do
    link = FactoryGirl.create(:tracking_link)
    
    expect(link.code).not_to be_nil
  end
  
  it 'generates a four-character code' do
    link = FactoryGirl.create(:tracking_link)
    
    expect(link.code.length).to eql(4)
  end
  
  it 'correctly marks as converted' do
    link = FactoryGirl.create(:tracking_link)
    
    link.mark_as_converted
    
    expect(link.converted).to be_truthy
    expect(link.converted_at).not_to be_nil
  end
  
  it 'shows as usable if not converted' do
    link = FactoryGirl.build_stubbed(:tracking_link)
    
    expect(link.usable?).to be_truthy
  end
  
  it 'shows as unusable if converted' do
    link = FactoryGirl.create(:tracking_link)
    
    link.mark_as_converted
    
    expect(link.usable?).to be_falsy
  end
end
