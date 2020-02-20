require 'rails_helper'

RSpec.describe Masseurs::RegistrationsController, type: :controller do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:masseur]
  end
    
  describe 'POST create' do
    context 'All contexts' do
      # it 'logs in after successful creation' do
      #
      # end
    end
    
    context 'HTML' do
      # it 'creates a masseur' do
      #
      # end
    end
    
    context 'JSON' do    
      it 'creates a masseur' do
        # Create a SiteSetting so the callbacks don't fail.
        # For some reason this doesn't work in a before(:suite) block?
        settings = FactoryGirl.create(:site_setting)
              
        xhr :post, :create, { format: :json,
                        masseur: {
                          email: 'tim@atomicpromise.com',
                          password: 'p4ssw0rD!',
                          password_confirmation: 'p4ssw0rD!',
                          dob: '1983-11-08'
                        }
                      }
                              
        expect(response.status).to eq(200)      
        expect(response.success?).to be_truthy
      end
    
      it 'fails to create a masseur' do
        xhr :post, :create, { format: :json,
                        masseur: {
                          email: 'tim@atomicpromise.com',
                          password: 'badpassword',
                          password_confirmation: 'doesntevenmatch!',
                          dob: '1983-11-08'
                        }
                      }
                      
        expect(response.status).to eq(422)
        expect(response.success?).to be_falsy
      end
    end
  end
end