# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# LANGUAGES
Language.create("english_name"=>"English", "native_name"=>"English", "iso_code"=>"en")
Language.create("english_name"=>"Japanese", "native_name"=>"日本語", "iso_code"=>"ja")
Language.create("english_name"=>"Arabic", "native_name"=>"العَرَبِيةُ‎‎", "iso_code"=>"ar")
Language.create("english_name"=>"Cantonese", "native_name"=>"廣州話", "iso_code"=>"zh")
Language.create("english_name"=>"Dutch", "native_name"=>"Nederlands", "iso_code"=>"nl")
Language.create("english_name"=>"French", "native_name"=>"Français", "iso_code"=>"fr")
Language.create("english_name"=>"German", "native_name"=>"Deutsch", "iso_code"=>"de")
Language.create("english_name"=>"Hindi", "native_name"=>"हिन्दी", "iso_code"=>"hi")
Language.create("english_name"=>"Italian", "native_name"=>"Italiano", "iso_code"=>"it")
Language.create("english_name"=>"Hebrew", "native_name"=>"עברית", "iso_code"=>"he")
Language.create("english_name"=>"Korean", "native_name"=>"한국어", "iso_code"=>"ko")
Language.create("english_name"=>"Mandarin", "native_name"=>"官话", "iso_code"=>"zh")
Language.create("english_name"=>"Polish", "native_name"=>"Polski", "iso_code"=>"pl")
Language.create("english_name"=>"Portuguese", "native_name"=>"Português", "iso_code"=>"pt")
Language.create("english_name"=>"Russian", "native_name"=>"ру́сский", "iso_code"=>"ru")
Language.create("english_name"=>"Spanish", "native_name"=>"Español", "iso_code"=>"es")
Language.create("english_name"=>"Tagalog", "native_name"=>"Tagalog", "iso_code"=>"tl")

# MASSAGE TECHNIQUES
MassageTechnique.create("name"=>"4 hands massage")
MassageTechnique.create("name"=>"Acupressure")
MassageTechnique.create("name"=>"Aromatherapy")
MassageTechnique.create("name"=>"Bioenergetics")
MassageTechnique.create("name"=>"Body electric")
MassageTechnique.create("name"=>"Chair massage")
MassageTechnique.create("name"=>"Custom")
MassageTechnique.create("name"=>"Deep muscle")
MassageTechnique.create("name"=>"Deep tissue")
MassageTechnique.create("name"=>"Erotic massage")
MassageTechnique.create("name"=>"Hot stone therapy")
MassageTechnique.create("name"=>"Integrative massage")
MassageTechnique.create("name"=>"Lomi")
MassageTechnique.create("name"=>"Lymph drainage")
MassageTechnique.create("name"=>"Myofascial")
MassageTechnique.create("name"=>"Neuromuscular")
MassageTechnique.create("name"=>"Orthopedic massage")
MassageTechnique.create("name"=>"Rebalancing")
MassageTechnique.create("name"=>"Reflexology")
MassageTechnique.create("name"=>"Reiki")
MassageTechnique.create("name"=>"Rolfing")
MassageTechnique.create("name"=>"Sensual")
MassageTechnique.create("name"=>"Shiatsu")
MassageTechnique.create("name"=>"Sports massage")
MassageTechnique.create("name"=>"Swedish massage")
MassageTechnique.create("name"=>"Thai")
MassageTechnique.create("name"=>"Trigger point")
MassageTechnique.create("name"=>"Yoga")
MassageTechnique.create("name"=>"Zero balancing")
MassageTechnique.create("name"=>"Craniosacral therapy")

# MASSAGE PRODUCTS
MassageProduct.create("name"=>"Aloe Vera Massage Oil")
MassageProduct.create("name"=>"Aveda Lotion")
MassageProduct.create("name"=>"Aveda Oil")
MassageProduct.create("name"=>"Biotone Lotion")
MassageProduct.create("name"=>"Biotone Oil")
MassageProduct.create("name"=>"Biotone Gel")
MassageProduct.create("name"=>"Heated Oil")
MassageProduct.create("name"=>"Heated Lotion")
MassageProduct.create("name"=>"Massage Oil")
MassageProduct.create("name"=>"Massage Gel")
MassageProduct.create("name"=>"Massage Cream")
MassageProduct.create("name"=>"Other")

# MASSAGE TYPES
MassageType.create("name"=>"Therapeutic")
MassageType.create("name"=>"Relaxation")
MassageType.create("name"=>"Customized")

# SERVICES
Service.create("name"=>"Massage")
Service.create("name"=>"Interpreter")
Service.create("name"=>"Stripper")
Service.create("name"=>"Modeling")
Service.create("name"=>"Tour Guide")
Service.create("name"=>"Travel Companion")
Service.create("name"=>"Personal Trainer")
Service.create("name"=>"Body Grooming")
Service.create("name"=>"Escort")

# BUILDS
Build.create("name"=>"Thin")
Build.create("name"=>"Swimmer")
Build.create("name"=>"Athletic")
Build.create("name"=>"Muscular/Buff")
Build.create("name"=>"Body Builder")
Build.create("name"=>"Stocky")
Build.create("name"=>"Heavy")

# BODYHAIRS
BodyHair.create("hairiness"=>"Smooth")
BodyHair.create("hairiness"=>"Shaven")
BodyHair.create("hairiness"=>"Some Hair")
BodyHair.create("hairiness"=>"Very Hairy")
BodyHair.create("hairiness"=>"Bear")

# HAIRCOLORS
HairColor.create("color"=>"Blonde")
HairColor.create("color"=>"Brown")
HairColor.create("color"=>"Ginger")
HairColor.create("color"=>"Dark")
HairColor.create("color"=>"Black")
HairColor.create("color"=>"Bald")
HairColor.create("color"=>"Other")

# EYECOLORS
EyeColor.create("color"=>"Blue")
EyeColor.create("color"=>"Hazel")
EyeColor.create("color"=>"Green")
EyeColor.create("color"=>"Grey")
EyeColor.create("color"=>"Brown")
EyeColor.create("color"=>"Other")

# SMOKINGFREQUENCIES
SmokingFrequency.create("frequency"=>"Never")
SmokingFrequency.create("frequency"=>"Occasional")
SmokingFrequency.create("frequency"=>"Chimney")
SmokingFrequency.create("frequency"=>"Ask Me")

# DRUGFREQUENCIES
DrugFrequency.create("frequency"=>"Never")
DrugFrequency.create("frequency"=>"Occasional")
DrugFrequency.create("frequency"=>"Frequently")
DrugFrequency.create("frequency"=>"Ask Me")

# SEXUALORIENTATIONS
SexualOrientation.create("orientation"=>"Gay")
SexualOrientation.create("orientation"=>"Bisexual")
SexualOrientation.create("orientation"=>"Straight")
SexualOrientation.create("orientation"=>"Ask Me")

# ETHNICITIES
Ethnicity.create("name"=>"Black")
Ethnicity.create("name"=>"Latino/Hispanic")
Ethnicity.create("name"=>"Middle Eastern")
Ethnicity.create("name"=>"Caucasian")
Ethnicity.create("name"=>"Pacific Islander")
Ethnicity.create("name"=>"Native American")
Ethnicity.create("name"=>"Mediterranean")
Ethnicity.create("name"=>"Other")

# StaticPages
File.open("#{Rails.root}/lib/static_pages/advertise-with-us.html", 'r') do |f|
  @advertise = StaticPage.create(title: 'Advertise with Us', content: f.read)
end

File.open("#{Rails.root}/lib/static_pages/privacy-policy.html", 'r') do |f|
  @privacy = StaticPage.create(title: 'Privacy Policy', content: f.read)
end

File.open("#{Rails.root}/lib/static_pages/terms-of-service.html", 'r') do |f|
  @tos = StaticPage.create(title: 'Terms of Service', content: f.read)
end

# Settings
badge_disclaimer = 'M4M never endorses, recommends or confirms the details about any Masseur. It is the Client’s responsibility to thoroughly vet any Masseur with whom they choose to meet or do business. M4M is NOT responsible or liable for any interaction or transactions that may occur between Masseurs and Clients.'

SiteSetting.create(basic_package_price: 39,
                   premium_package_price: 79,
                   approval_required_for_new_masseurs: true,
                   advertise_page: @advertise.id,
                   privacy_page: @privacy.id,
                   tos_page: @tos.id,
                   badge_disclaimer: badge_disclaimer)

# Work Locations
['My Place', 'Your Place', 'Hotels'].map { |loc| WorkLocation.create(name: loc) }

# Work Surfaces
['Table', 'Floor', 'Mat', 'Bed', 'Other'].map { |surface| WorkSurface.create(name: surface) }

# Client Types
['Straight Men', 'Bi Men', 'Gay Men', 'Male Couples', 'Trans Women', 'Women', 'Female Couples'].map { |type| ClientType.create(name: type) }