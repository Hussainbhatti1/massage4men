FactoryGirl.define do
  factory :masseur_detail do
    display_real_age  false
    display_age       25
    
    home_base_city    'Chicago'
    home_base_state   'IL'
    home_base_zip     '60657'
    
    height_feet       5
    height_inches     9
    weight            125
    weight_unit       'lbs'
    
    display_phone     '(773) 234-7829'
    
    show_facebook     true
    facebook_url      'atomicpromise'
    
    # TODO: Finish this factory!
  end
end
