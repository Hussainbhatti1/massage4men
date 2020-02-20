class SubscriptionsController < ApplicationController
  require 'active_merchant/billing/rails'

  # Handle authentication and authorization, except on postbacks
  before_action :authenticate_masseur!, except: :postback
  before_action :set_page_title, except: :postback
  
  skip_before_filter :verify_authenticity_token, only: :postback
  skip_authorization_check only: :postback

  load_and_authorize_resource :masseur, except: :postback
  load_and_authorize_resource through: :masseur, except: :postback
  
  respond_to :json, only: :create
  
  def new
    # If we have an active subscription already, redirect back
    if current_masseur.active_subscription
      redirect_to :back, notice: 'You already have an active subscription. Thank you!'
    end
    
    # Hide progress bar, red expired subscription notice, etc.
    # We want to focus strictly on the renewal form
    @hide_masseur_notices = true
    
    @card ||= ActiveMerchant::Billing::CreditCard.new
    @code ||= PromoCode.new
    
    if request.xhr?    
      render 'new_modal', layout: false
    end
  end
  
  def create
    # Create the Card so we can validate it right away
    @card = ActiveMerchant::Billing::CreditCard.new(card_params) 

    # Find promo code - if it exists
    if params[:code].present? && params[:code][:code].present?
      # promo_code = PromoCode.find_by code: params[:code][:code]
      promo_code = PromoCode.where("lower(code) = ? AND active = true AND start_date <= ?", params[:code][:code].downcase, Time.now).first
    
      if !promo_code
        # Validating the card here ensures that we have errors for it if the promo code is bad
        @card.valid?
        @code = PromoCode.new(code: params[:code][:code])
        @code.errors.add(:code, 'Invalid promo code.')

        return render :new
      else
        if promo_code.expired?
          @card.valid?
          @code = PromoCode.new(code: params[:code][:code])
          @code.errors.add(:code, 'This promo code has expired.')
          
          return render :new          
        else
          @subscription.promo_code = promo_code          
        end
      end
    end

    # Set the subscription type:
    # If we're coming from the signup process then signup_ad_type will be defined.
    # Otherwise it needs to come from the Renewal/Activation form
    if signup_ad_type
      if signup_ad_type == 'basic'
        @subscription.subscription_type = SUBSCRIPTION_BASIC
      elsif signup_ad_type == 'premium'
        @subscription.subscription_type = SUBSCRIPTION_PREMIUM
      end
    end

    if @card.valid? && @subscription.valid?
      # Do the charge. All the magic is in the model.
      result = @subscription.create_recurring_subscription(@card)
      
      if result.success
        # Everything went fine! The model activated and saved itself so we don't have to worry about that.
        # Kill the session var that tracks signup_in_progress
        session[:m4m] = nil if session[:m4m]
        
        # Send to the Success page!
        flash[:notice] = 'Your subscription has been activated.'
        
        respond_to do |format|
          format.html { redirect_to dashboard_masseur_path(@subscription.masseur) }
          format.json { render json: { success: true, dashboard_url: dashboard_masseur_path(@subscription.masseur) } }
        end
      else
        respond_to do |format|
          format.html {
            flash[:error] = result.message
            render 'new'
          }
          
          format.json {
            render json: { success: false, errors: {test: result.message}, status: :unprocessable_entity}
          }
        end
      end
    else
      respond_to do |format|
        format.html { render 'new' }
        format.json { render json: { success: false, errors: { card: @card.errors } }, status: :unprocessable_entity }
      end
    end
  end
  
  def success
    
  end
  
  # BEGIN: AUTHORIZE.NET POSTBACKS
  def postback
    # Find the subscription associated with this transaction
    sub = Subscription.find_by(gateway_subscription_id: params[:x_subscription_id])
    
    # Let us know if we can't find the Subscription
    if !sub
      AdminMailer.postback_subscription_not_found(params).deliver_later
      render json: {success: false, error: "Could not find subscription with ID #{params[:x_subscription_id]}"}
    else
      # Create a new transaction off of this Subscription
      trans = sub.subscription_transactions.build
      trans.success = (params[:x_response_code].to_i == TRANSACTION_APPROVED ? true : false)
      trans.serialized_response = params.to_json
      trans.amount_charged = params[:x_amount]
      
      if trans.save    
        render json: {success: true, msg: "Successfully updated subscription #{params[:x_subscription_id]}"}
      else
        render json: {success: false, msg: "Could not save update to subscription #{params[:x_subscription_id]}"}
      end
    end
  end
  
  
  
  
  
  
  private
  def set_page_title
    @page_title = 'My Subscription'
  end
  
  def subscription_params
    params.require(:subscription).permit(:masseur_id,
                                         :promo_code,
                                         :type,
                                         :subscription_type,
                                         :active) if params[:subscription]
  end
  
  def card_params
    params.require(:card).permit(:first_name,
                                 :last_name,
                                 :number,
                                 :month,
                                 :year,
                                 :verification_value,
                                 :expiry_string)
  end
end
