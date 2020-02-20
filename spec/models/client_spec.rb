require 'rails_helper'

RSpec.describe Client do
  describe 'Validations' do
    it 'correctly validates minimum age' do
      client = FactoryGirl.build_stubbed(:client, dob: 18.years.ago)
      expect(client.valid?).to be_truthy

      client.dob = 18.years.ago + 1.day
      expect(client.valid?).to be_falsy
    end
    
    it "refuses a client with an existing client's screen name" do
      client = FactoryGirl.create(:client, dob: 30.years.ago, screen_name: 'testy')
      client2 = FactoryGirl.build_stubbed(:client, dob: 40.years.ago, screen_name: 'testy')
      
      expect(client2).to be_invalid
    end


    it "refuses a client with an existing masseur's screen name" do
      FactoryGirl.create(:site_setting)
      
      masseur = FactoryGirl.create(:masseur, :complete, dob: 30.years.ago, screen_name: 'testy')
      client2 = FactoryGirl.build_stubbed(:client, dob: 40.years.ago, screen_name: 'testy')
      
      expect(client2).to be_invalid
    end
  end
  
  describe 'Setter Overrides' do
    it 'corrects a datetime to a date' do
      client = FactoryGirl.build_stubbed(:client, dob: 30.years.ago)
      
      expect(client.dob.class).to eql(Date)
      expect(client.valid?).to be_truthy
    end
    
    it 'strips all non-numerics out of the phone number' do
      phone1 = Faker::PhoneNumber.phone_number
      client = FactoryGirl.build_stubbed(:client, phone: phone1)
      
      expect(client.phone).to eql(phone1.gsub(/\D/, ''))
    end
  end

  it 'correctly concatenates first and last name' do
    # No need to test only first or last names since both are required
    client = FactoryGirl.build_stubbed(:client, first_name: 'Timothy', last_name: 'Testerson')
    expect(client.full_name).to eq('Timothy Testerson')
  end
  
  it 'correctly determines display name' do
    client = FactoryGirl.build_stubbed(:client, first_name: 'Timothy', screen_name: 'testytimothy')
    expect(client.display_name).to eq('testytimothy')
    
    client.screen_name = nil
    expect(client.display_name).to eq('Timothy')
  end  
end
