class PromoCodesController < ApplicationController
  skip_authorization_check

  skip_before_action :verify_authenticity_token
  
  respond_to :json, only: :check
  
  def check
    if params[:promo_code][:code].blank? || params[:promo_code][:subscription_type].blank? || ![SUBSCRIPTION_BASIC.to_s, SUBSCRIPTION_PREMIUM.to_s].include?(params[:promo_code][:subscription_type].to_s)
      ret = { valid: false, error: 'Invalid parameters.'}
    else
      code = PromoCode.find_by('lower(code) = ?', params[:promo_code][:code].downcase)
      subscription_type = params[:promo_code][:subscription_type].to_i

      if code && code.usable?
        if !code.requires_payment?(subscription_type)
          ret = { valid: true,
                  code: code.code,
                  description: code.description,
                  dashboard_url: dashboard_masseur_url(current_masseur)
                }

          # Create a Trial object
          trial = current_masseur.build_trial(promo_code: code,
                                      subscription_type: subscription_type,
                                      active: true,
                                      seven_day_email_sent: false,
                                      fourteen_day_email_sent: false,
                                      ends_at: code.length_in_days.days.from_now.end_of_day)

          if trial.save
            flash[:success] = "Code accepted! Enjoy your #{code.length_in_days}-day trial. We'll notify you when it's about to expire."            
          end
        else
          ret = { valid: true,
                  code: code.code,
                  description: code.description,
                  requires_payment: code.requires_payment?(subscription_type)
                }          
        end
      else
        ret = {valid: false, errors: {code: 'Promo code is invalid.'}}
      end      
    end
    
    respond_to do |format|
      format.json { render json: ret, status: (ret[:valid] ? :ok : :unprocessable_entity) }
    end
  end
end
