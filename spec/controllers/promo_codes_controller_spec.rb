require 'rails_helper'

RSpec.describe PromoCodesController, type: :controller do
  describe 'POST check' do
    context 'JSON' do
      context 'Sanity checking' do
        it 'fails if no code is passed' do
          xhr :post, :check, { format: :json,
                         promo_code: {
                           subscription_type: SUBSCRIPTION_BASIC
                         }
          }

          json = JSON.parse(response.body)

          expect(response.status).to eq(422)
          expect(response.success?).to be_falsy
          expect(json['valid']).to be_falsy
        end
      
        it 'fails if no subscription type is passed' do
          xhr :post, :check, { format: :json,
                         promo_code: {
                           code: 'SOMECODE'
                         }
          }

          json = JSON.parse(response.body)
                
          expect(response.status).to eq(422)
          expect(response.success?).to be_falsy
          expect(json['valid']).to be_falsy
        end
      
        it 'fails if an invalid subscription type is passed' do
          xhr :post, :check, { format: :json,
                         promo_code: {
                           code: 'SOMECODE',
                           subscription_type: 3
                         }
          }
        
          json = JSON.parse(response.body)
        
          expect(response.status).to eq(422)
          expect(response.success?).to be_falsy        
          expect(json['valid']).to be_falsy
        end
      end
      
      context 'With valid input' do
        it 'fails if code doesn\'t exist' do
          xhr :post, :check, { format: :json,
                         promo_code: {
                           code: 'SOMECODE',
                           subscription_type: SUBSCRIPTION_BASIC
                         }
          }
          
          json = JSON.parse(response.body)
          
          expect(response.status).to eq(422)
          expect(response.success?).to be_falsy
          expect(json['valid']).to be_falsy          
        end
        
        it 'fails if an existing code is inactive' do
          inactive_code = FactoryGirl.create(:promo_code, :inactive, :total_discount)
          
          xhr :post, :check, {
            format: :json,
            promo_code: inactive_code
          }
          
          json = JSON.parse(response.body)
          
          expect(response.status).to eq(422)
          expect(response.success?).to be_falsy
          expect(json['valid']).to be_falsy
        end
        
        it 'fails if an existing code is expired' do
          expired_code = FactoryGirl.create(:promo_code, :expired, :total_discount)
          
          xhr :post, :check, {
            format: :json,
            promo_code: expired_code
          }
          
          json = JSON.parse(response.body)
          
          expect(response.status).to eq(422)
          expect(response.success?).to be_falsy
          expect(json['valid']).to be_falsy          
        end
        
        it 'creates a trial and redirects to dashboard if discount is 100%' do
          # The user must be signed in for this action to work.
          # Before we can create a Masseur, we need a SiteSetting
          FactoryGirl.create(:site_setting)
          
          # Create a Masseur and sign him in.
          sign_in FactoryGirl.create(:masseur)

          # Now proceed with checking the PromoCode
          code = FactoryGirl.create(:promo_code, :total_discount)
          
          # We have to specify the subscription_type here since it's a virtual attribute
          xhr :post, :check, {
            format: :json,
            promo_code: { code: code.code, subscription_type: SUBSCRIPTION_BASIC }
          }
          
          json = JSON.parse(response.body)
          
          expect(response.status).to eq(200)
          expect(response.success?).to be_truthy
          expect(json['valid']).to be_truthy
          expect(json['code']).to eql(code.code)
          expect(json['description']).to eql(code.description)
          
        end
      end
      
      context 'Other' do
        
      end
    end
  end
end
