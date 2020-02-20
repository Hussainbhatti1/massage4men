require 'rails_helper'

RSpec.describe Photo do
  it 'sets as approved' do
    # Create unapproved, SFW photo
    photo = FactoryGirl.create(:photo)
    
    photo.approve
    
    expect(photo.approved).to be_truthy
  end
  
  it 'sets as adult-approved' do
    photo = FactoryGirl.create(:photo, :adult)
    
    photo.approve_as_adult
    
    expect(photo.adult).to be_truthy
    expect(photo.approved).to be_truthy    
  end
  
  it 'sets as unapproved' do
    photo = FactoryGirl.build_stubbed(:photo, :approved)
    
    photo.set_unapproved
    
    expect(photo.approved).to be_falsy    
  end
  
  # it 'sets as denied' do
  #   photo = FactoryGirl.create(:photo)
  #
  #   photo.deny
  #
  #   expect(photo).to be_nil
  # end
end
