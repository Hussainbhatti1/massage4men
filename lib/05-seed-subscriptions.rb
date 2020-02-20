# seed-subscriptions.rb
used_sub_ids = []
CARD_TYPES = [:visa, :mastercard, :discover, :amex, :diners]

Masseur.where(approved: true).each do |m|
  # 94% of active masseurs should be assigned 1 or more subscriptions
  if Random.rand(100) <= 94
    sub = m.subscriptions.build(active: true)
    
    sub_id = Random.rand(9999999)
    
    if !used_sub_ids.include? sub_id
      used_sub_ids << sub_id
      
      sub.gateway_subscription_id = sub_id
      
      if Random.rand(100) <= 64
        sub.subscription_type = SUBSCRIPTION_BASIC 
        amount_charged = 39       
      else
        sub.subscription_type = SUBSCRIPTION_PREMIUM
        amount_charged = 79
      end

      if sub.save
        # Create SubscriptionTransactions
        card_brand = CARD_TYPES.sample
        card_number = CreditCardValidations::Factory.random(card_brand)        
        
        trans = sub.subscription_transactions.build(amount_charged: amount_charged, success: true, card_brand: card_brand.to_s, cc_last_four: card_number[-4..-1])
        trans.serialized_response = {success: true}.to_json
        
        if trans.save
          puts '!= SUBSCRIPTION & TRANSACTION SAVE OK'
        else
          puts '!= SUBSCRIPTION TRANSACTION SAVE FAILED'
          puts trans.errors.inspect
        end
        
      else
        puts "-! SUBSCRIPTION SAVE FAILED"
        puts sub.errors.inspect
      end
      
    end
  end
end