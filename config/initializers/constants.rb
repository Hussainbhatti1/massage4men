ROLE_MODERATOR = 0
ROLE_ADMIN = 1

# ROLE_CLIENT = 0
# ROLE_MASSEUR = 1
# ROLE_ADMIN = 2

SUBSCRIPTION_BASIC = 0
SUBSCRIPTION_PREMIUM = 1

AD_TYPES = ['basic', 'premium']

RATE_TYPES = ['Incall', 'Outcall', 'Other Service']

RATE_INCALL = 0
RATE_OUTCALL = 1
RATE_OTHER = 2

NEARBY_SEARCH_RADIUS = 50

BASIC_LOCAL_AD_LIMIT = 1
PREMIUM_LOCAL_AD_LIMIT = 3

BASIC_TRAVEL_AD_LIMIT = 1
PREMIUM_TRAVEL_AD_LIMIT = 6

BASIC_AVAILABILITY_LIMIT = 6

INFINITE_SUBSCRIPTION_OCCURRENCES = 9999
BILLING_INTERVAL = 30 # days between billings

DEFAULT_TRIAL_LENGTH_IN_DAYS = 30

# Authorize.net response codes
TRANSACTION_APPROVED = 1
TRANSACTION_DENIED = 2
TRANSACTION_ERROR = 3
TRANSACTION_HELD_FOR_REVIEW = 4

ADMIN_EMAIL = 'tim@timspangler.com'

# These are the methods on the Client/Masseur objects allowed as interpolatable variables
EMAIL_INTERPOLATION_WHITELIST = [
  '{$FIRST_NAME}',
  '{$FULL_NAME}',
  '{$SCREEN_NAME}',
  '{$EMAIL}',
  '{$CITY}',
  '{$STATE}'
]

# SFW mode - NSFW by default
if ENV['M4M_SFW_MODE'].nil?
  SFW_MODE = false  
else
  if ENV['M4M_SFW_MODE'] == 'true'
    SFW_MODE = true    
  else
    SFW_MODE = false
  end  
end

puts "M4M.net running in #{SFW_MODE ? 'SFW' : 'NSFW'} mode."

# Allowable filetypes for photos
ALLOWED_PHOTO_FILETYPES = ['image/jpeg',
                           'image/gif',
                           'image/png']


# Allowable filetypes for documentation
ALLOWED_MASSEUR_DOCUMENTATION_FILETYPES = ['image/jpeg',
                                           'image/gif',
                                           'image/png',
                                           'application/pdf',
                                           'application/msword',
                                           'application/vnd.openxmlformats-officedocument.wordprocessingml.document']

AUTHORIZE_NET_LOGIN = ""
AUTHORIZE_NET_KEY = ""
AUTHORIZE_NET_USE_TEST_MODE = true

GOOGLE_MAPS_API_KEY = "AIzaSyDwdgehv0fY_gfln2GXkHT0P27CWxsSSHM"                                           