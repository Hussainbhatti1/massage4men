require 'rails_helper'

RSpec.describe Masseur, type: :model do
  describe 'Validations' do
    it 'correctly validates minimum age' do
      masseur = FactoryGirl.build_stubbed(:masseur, :complete, dob: 18.years.ago)
      expect(masseur.valid?).to be_truthy

      masseur.dob = 18.years.ago + 1.day
      expect(masseur.valid?).to be_falsy
    end
    
    it "refuses a masseur with an existing client's screen name" do
      client = FactoryGirl.create(:client, screen_name: 'testy')
      masseur = FactoryGirl.build_stubbed(:masseur, :complete, screen_name: 'testy')
      
      expect(masseur).to be_invalid
    end


    it "refuses a masseur with an existing masseur's screen name" do
      FactoryGirl.create(:site_setting)
      
      masseur = FactoryGirl.create(:masseur, :complete, screen_name: 'testy')
      masseur2 = FactoryGirl.build_stubbed(:masseur, :complete, screen_name: 'testy')
      
      expect(masseur2).to be_invalid
    end
    
  end

  describe 'Setter Overrides' do
    it 'corrects a datetime to a date' do
      masseur = FactoryGirl.build_stubbed(:masseur, :complete, dob: 30.years.ago)
      
      expect(masseur.dob.class).to eql(Date)
      expect(masseur.valid?).to be_truthy
    end
    
    it 'strips all non-numerics out of the phone number' do
      phone1 = Faker::PhoneNumber.phone_number
      masseur = FactoryGirl.build_stubbed(:masseur, contact_phone: phone1)
      
      expect(masseur.contact_phone).to eql(phone1.gsub(/\D/, ''))
    end
  end
  
  describe 'Instance Methods' do
    it 'displays the proper age' do
      # Case 1: No MasseurDetail record
      # Expected age: 30
      masseur = FactoryGirl.build_stubbed(:masseur,
                                          dob: 30.years.ago)
      
      expect(masseur.age).to eql(30)

      # Case 2: MasseurDetail says "display real age"
      masseur = FactoryGirl.build_stubbed(:masseur,
                                          :complete,
                                          masseur_detail: FactoryGirl.build_stubbed(:masseur_detail),
                                          dob: 30.years.ago)

      masseur.masseur_detail.attributes = {
        display_real_age: true,
        display_age: nil
      }

      expect(masseur.age).to eql(30)
      
      # Case 3: MasseurDetail says "use display age" of 20
      masseur.masseur_detail.attributes = {
        display_real_age: false,
        display_age: 20
      }

      expect(masseur.age).to eql(20)
    end

    # DEPRECATED TEST. Removing!
    # it 'calculates its completed percentage' do
    #   # Build a minimal masseur (email, password, dob)
    #   masseur = FactoryGirl.build_stubbed(:masseur)
    #   expect(masseur.completed_percentage).to eql(10)
    #
    #   # Build a complete Masseur object with no details
    #   complete_masseur = FactoryGirl.build_stubbed(:masseur, :complete)
    #   expect(complete_masseur.completed_percentage).to eql(30)
    #
    #   # Complete Masseur object with details
    #   complete_masseur_with_detail = FactoryGirl.build_stubbed(:masseur,
    #                                                            :complete,
    #                                                             masseur_detail: FactoryGirl.build_stubbed(:masseur_detail))
    #   expect(complete_masseur_with_detail.completed_percentage).to eql(50)
    #
    #   # Complete Masseur object with at least one photo
    #   masseur4 = FactoryGirl.build_stubbed(:masseur,
    #                                 :complete,
    #                                 masseur_detail: FactoryGirl.build_stubbed(:masseur_detail),
    #                                 photos: FactoryGirl.build_list(:photo, Random.rand(1..3)))
    #
    #   expect(masseur4.completed_percentage).to eql(75)
    #
    #   # Complete Masseur object with at least one photo and one ad
    #   photos = FactoryGirl.build_list(:photo, Random.rand(1..3))
    #   ads = FactoryGirl.build_stubbed(:ad, photos: photos)
    #
    #   masseur5 = FactoryGirl.build_stubbed(:masseur,
    #                                        :complete,
    #                                        masseur_detail: FactoryGirl.build_stubbed(:masseur_detail),
    #                                        photos: photos,
    #                                        ads: [ads])
    #
    #   expect(masseur5.completed_percentage).to eql(100)
    # end
    
    # TODO: Update this test when we have an "approved" attribute on ads
    # Also it's dependent on a SiteSettings object being made, but if we do it in a let block it never deletes itself?!?!?!
  #   it 'correctly reports if it has active ads' do
  #     masseur = FactoryGirl.create(:masseur)
  #
  #     # Create two ads
  #     (1..2).each do |n|
  #       masseur.ads << FactoryGirl.create(:ad)
  #     end
  #
  #     expect(masseur.has_approved_ads?).to be_truthy
  #     # expect(masseur.approved_ads).to eql(2)
  #   end
  end

  # describe 'Callbacks' do
  #   it 'sets masseur\'s approval status according to SiteSettings' do
  #     settings = FactoryGirl.create(:site_setting)
  #     masseur = FactoryGirl.create(:masseur)
  #
  #     expect(masseur.approved?).to eql(!settings.approval_required_for_new_masseurs)
  #   end
  #
  #   it 'marks tracking link as converted if used' do
  #     t = FactoryGirl.create(:tracking_link)
  #     m = FactoryGirl.build(:masseur, tracking_link: t)
  #
  #     m.save
  #
  #     expect(t.usable?).to be_falsy
  #     expect(t.converted).to be_truthy
  #     expect(t.converted_at).not_to be_nil
  #   end
  # end
end
