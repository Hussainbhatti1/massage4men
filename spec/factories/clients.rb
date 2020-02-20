FactoryGirl.define do
  factory :client do
    email       'tim@atomicpromise.com'
    first_name  'Timothy'
    last_name   'Testerson'
    screen_name 'timmytesterson'
    dob         Date.parse('1984-11-02')
    
    city        'Las Vegas'
    state       'NV'
    zip         '89101'
    
    phone       '(773) 234-7829'
    phone_type  ['Mobile', 'Landline'].sample
    
    email_new_masseurs            [true, false].sample
    email_masseur_profile_update  [true, false].sample
    email_weekly_update           [true, false].sample
    
    password              'p4ssW0rd!'
    password_confirmation 'p4ssW0rd!'
  end
end
