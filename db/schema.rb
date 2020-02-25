# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20200225102342) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ad_photos", force: :cascade do |t|
    t.integer  "ad_id"
    t.integer  "photo_id"
    t.integer  "display_order"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "primary",       default: false
    t.integer  "travel_ad_id"
  end

  add_index "ad_photos", ["ad_id"], name: "index_ad_photos_on_ad_id", using: :btree
  add_index "ad_photos", ["photo_id"], name: "index_ad_photos_on_photo_id", using: :btree
  add_index "ad_photos", ["travel_ad_id"], name: "index_ad_photos_on_travel_ad_id", using: :btree

  create_table "admins", force: :cascade do |t|
    t.string   "email",               default: "", null: false
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "role"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree

  create_table "admins_site_setting_logs", id: false, force: :cascade do |t|
    t.integer "site_setting_log_id", null: false
    t.integer "admin_id",            null: false
  end

  add_index "admins_site_setting_logs", ["admin_id", "site_setting_log_id"], name: "index_admin_logs", using: :btree
  add_index "admins_site_setting_logs", ["site_setting_log_id", "admin_id"], name: "index_site_logs", using: :btree

  create_table "ads", force: :cascade do |t|
    t.integer  "masseur_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "massage_type_id"
    t.text     "about_me"
    t.text     "about_my_services"
  end

  add_index "ads", ["massage_type_id"], name: "index_ads_on_massage_type_id", using: :btree
  add_index "ads", ["masseur_id"], name: "index_ads_on_masseur_id", using: :btree

  create_table "airports", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "body_hairs", force: :cascade do |t|
    t.string   "hairiness"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "builds", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "client_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "client_types_masseur_details", id: false, force: :cascade do |t|
    t.integer "client_type_id",    null: false
    t.integer "masseur_detail_id", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string   "email"
    t.string   "encrypted_password",                     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.date     "dob"
    t.string   "date"
    t.string   "phone"
    t.string   "phone_type"
    t.boolean  "email_new_masseurs"
    t.boolean  "email_masseur_profile_update"
    t.boolean  "email_weekly_update"
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "profile_photo_file_name"
    t.string   "profile_photo_content_type"
    t.integer  "profile_photo_file_size",      limit: 8
    t.datetime "profile_photo_updated_at"
    t.string   "screen_name"
    t.string   "slug"
    t.boolean  "active",                                 default: true
    t.string   "country",                                default: "US"
    t.boolean  "approved",                               default: false
  end

  add_index "clients", ["email"], name: "index_clients_on_email", unique: true, using: :btree
  add_index "clients", ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true, using: :btree
  add_index "clients", ["slug"], name: "index_clients_on_slug", unique: true, using: :btree

  create_table "drug_frequencies", force: :cascade do |t|
    t.string   "frequency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "emails", force: :cascade do |t|
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ethnicities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "eye_colors", force: :cascade do |t|
    t.string   "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "masseur_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "favorites", ["client_id"], name: "index_favorites_on_client_id", using: :btree
  add_index "favorites", ["masseur_id"], name: "index_favorites_on_masseur_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "hair_colors", force: :cascade do |t|
    t.string   "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "impressions", force: :cascade do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message"
    t.text     "referrer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "params"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "params"], name: "poly_params_request_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index", using: :btree
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id", using: :btree

  create_table "languages", force: :cascade do |t|
    t.string   "english_name"
    t.string   "native_name"
    t.string   "iso_code"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "mailboxer_conversation_opt_outs", force: :cascade do |t|
    t.integer "unsubscriber_id"
    t.string  "unsubscriber_type"
    t.integer "conversation_id"
  end

  add_index "mailboxer_conversation_opt_outs", ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id", using: :btree
  add_index "mailboxer_conversation_opt_outs", ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type", using: :btree

  create_table "mailboxer_conversations", force: :cascade do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "mailboxer_notifications", force: :cascade do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.string   "notification_code"
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "attachment"
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.boolean  "global",               default: false
    t.datetime "expires"
  end

  add_index "mailboxer_notifications", ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id", using: :btree
  add_index "mailboxer_notifications", ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type", using: :btree
  add_index "mailboxer_notifications", ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type", using: :btree
  add_index "mailboxer_notifications", ["type"], name: "index_mailboxer_notifications_on_type", using: :btree

  create_table "mailboxer_receipts", force: :cascade do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "mailboxer_receipts", ["notification_id"], name: "index_mailboxer_receipts_on_notification_id", using: :btree
  add_index "mailboxer_receipts", ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type", using: :btree

  create_table "massage_products", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "massage_products_masseur_details", id: false, force: :cascade do |t|
    t.integer "massage_product_id", null: false
    t.integer "masseur_detail_id",  null: false
  end

  create_table "massage_techniques", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "massage_techniques_masseur_details", id: false, force: :cascade do |t|
    t.integer "massage_technique_id", null: false
    t.integer "masseur_detail_id",    null: false
  end

  create_table "massage_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "massage_types_masseur_details", id: false, force: :cascade do |t|
    t.integer "massage_type_id",   null: false
    t.integer "masseur_detail_id", null: false
  end

  create_table "masseur_details", force: :cascade do |t|
    t.boolean  "display_real_age"
    t.integer  "display_age"
    t.string   "home_base_city"
    t.string   "home_base_state"
    t.string   "home_base_zip"
    t.string   "home_base_country"
    t.integer  "height_feet"
    t.integer  "weight"
    t.string   "weight_unit"
    t.string   "display_email"
    t.string   "display_phone"
    t.boolean  "show_facebook"
    t.string   "facebook_url"
    t.boolean  "show_website"
    t.string   "website_url"
    t.boolean  "show_linkedin"
    t.string   "linkedin_url"
    t.boolean  "show_pinterest"
    t.string   "pinterest_url"
    t.text     "about"
    t.integer  "years_of_massage_experience"
    t.text     "certifications"
    t.text     "additional_services"
    t.integer  "work_location"
    t.integer  "work_location_radius"
    t.string   "work_location_radius_zip"
    t.text     "services_details"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "build_id"
    t.integer  "body_hair_id"
    t.integer  "hair_color_id"
    t.integer  "eye_color_id"
    t.integer  "sexual_orientation_id"
    t.integer  "smoking_frequency_id"
    t.integer  "drug_frequency_id"
    t.integer  "ethnicity_id"
    t.integer  "height_inches"
    t.integer  "height_cm"
    t.integer  "masseur_id"
    t.float    "home_base_latitude"
    t.float    "home_base_longitude"
    t.text     "service_details"
  end

  add_index "masseur_details", ["body_hair_id"], name: "index_masseur_details_on_body_hair_id", using: :btree
  add_index "masseur_details", ["build_id"], name: "index_masseur_details_on_build_id", using: :btree
  add_index "masseur_details", ["drug_frequency_id"], name: "index_masseur_details_on_drug_frequency_id", using: :btree
  add_index "masseur_details", ["ethnicity_id"], name: "index_masseur_details_on_ethnicity_id", using: :btree
  add_index "masseur_details", ["eye_color_id"], name: "index_masseur_details_on_eye_color_id", using: :btree
  add_index "masseur_details", ["hair_color_id"], name: "index_masseur_details_on_hair_color_id", using: :btree
  add_index "masseur_details", ["masseur_id"], name: "index_masseur_details_on_masseur_id", using: :btree
  add_index "masseur_details", ["sexual_orientation_id"], name: "index_masseur_details_on_sexual_orientation_id", using: :btree
  add_index "masseur_details", ["smoking_frequency_id"], name: "index_masseur_details_on_smoking_frequency_id", using: :btree

  create_table "masseur_details_services", id: false, force: :cascade do |t|
    t.integer "masseur_detail_id", null: false
    t.integer "service_id",        null: false
  end

  create_table "masseur_details_work_locations", id: false, force: :cascade do |t|
    t.integer "work_location_id",  null: false
    t.integer "masseur_detail_id", null: false
  end

  create_table "masseur_details_work_surfaces", id: false, force: :cascade do |t|
    t.integer "work_surface_id",   null: false
    t.integer "masseur_detail_id", null: false
  end

  create_table "masseur_documentations", force: :cascade do |t|
    t.integer  "masseur_id"
    t.datetime "certification_submitted"
    t.boolean  "certification_approved"
    t.datetime "license_submitted"
    t.boolean  "license_approved"
    t.datetime "photo_id_submitted"
    t.boolean  "photo_id_approved"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "certification_file_name"
    t.string   "certification_content_type"
    t.integer  "certification_file_size",    limit: 8
    t.datetime "certification_updated_at"
    t.string   "license_file_name"
    t.string   "license_content_type"
    t.integer  "license_file_size",          limit: 8
    t.datetime "license_updated_at"
    t.string   "photo_id_file_name"
    t.string   "photo_id_content_type"
    t.integer  "photo_id_file_size",         limit: 8
    t.datetime "photo_id_updated_at"
    t.text     "certification_notes"
    t.text     "license_notes"
    t.text     "photo_id_notes"
  end

  add_index "masseur_documentations", ["masseur_id"], name: "index_masseur_documentations_on_masseur_id", using: :btree

  create_table "masseur_languages", force: :cascade do |t|
    t.integer  "language_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "masseur_detail_id"
  end

  add_index "masseur_languages", ["language_id"], name: "index_masseur_languages_on_language_id", using: :btree
  add_index "masseur_languages", ["masseur_detail_id"], name: "index_masseur_languages_on_masseur_detail_id", using: :btree

  create_table "masseurs", force: :cascade do |t|
    t.string   "email"
    t.string   "encrypted_password",                             default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                  default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "mailing_address"
    t.string   "mailing_unit"
    t.string   "mailing_city"
    t.string   "mailing_state"
    t.string   "mailing_zip"
    t.date     "dob"
    t.string   "contact_phone"
    t.string   "contact_phone_type"
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
    t.boolean  "provides_services_at_mailing_address"
    t.boolean  "approved",                                       default: false
    t.boolean  "featured",                                       default: false
    t.boolean  "available",                                      default: false
    t.string   "slug"
    t.string   "screen_name"
    t.integer  "tracking_link_id"
    t.boolean  "active",                                         default: true
    t.boolean  "notify_when_availability_expires",               default: true
    t.string   "mailing_country",                                default: "US"
    t.string   "profile_photo_file_name"
    t.string   "profile_photo_content_type"
    t.integer  "profile_photo_file_size",              limit: 8
    t.datetime "profile_photo_updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "is_deleted",                                     default: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "masseurs", ["confirmation_token"], name: "index_masseurs_on_confirmation_token", unique: true, using: :btree
  add_index "masseurs", ["email"], name: "index_masseurs_on_email", unique: true, using: :btree
  add_index "masseurs", ["reset_password_token"], name: "index_masseurs_on_reset_password_token", unique: true, using: :btree
  add_index "masseurs", ["slug"], name: "index_masseurs_on_slug", unique: true, using: :btree
  add_index "masseurs", ["tracking_link_id"], name: "index_masseurs_on_tracking_link_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.integer  "masseur_id"
    t.boolean  "adult",                          default: false
    t.boolean  "approved",                       default: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size",    limit: 8
    t.datetime "picture_updated_at"
  end

  add_index "photos", ["masseur_id"], name: "index_photos_on_masseur_id", using: :btree

  create_table "promo_codes", force: :cascade do |t|
    t.string   "code"
    t.string   "description"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "active"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "basic_discount_percentage"
    t.integer  "premium_discount_percentage"
    t.integer  "length_in_days"
    t.string   "seven_day_email_subject"
    t.text     "seven_day_email_content"
    t.string   "fourteen_day_email_subject"
    t.text     "fourteen_day_email_content"
  end

  create_table "rates", force: :cascade do |t|
    t.integer  "masseur_detail_id"
    t.integer  "rate_type"
    t.string   "rate"
    t.string   "time"
    t.text     "description"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "rates", ["masseur_detail_id"], name: "index_rates_on_masseur_detail_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "masseur_id"
    t.text     "review"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "rating"
    t.string   "times_seen"
    t.date     "appointment_date"
    t.string   "appointment_location"
    t.string   "appointment_scheduled_length"
    t.string   "appointment_actual_length"
    t.string   "masseur_on_time"
    t.boolean  "masseur_notified_of_lateness"
    t.integer  "incall_or_outcall"
    t.string   "service_as_requested"
    t.integer  "masseur_appearance"
    t.integer  "masseur_personality"
    t.integer  "likelihood_to_rebook"
    t.integer  "likelihood_to_refer"
    t.boolean  "masseur_approved",             default: false
    t.boolean  "admin_approved",               default: false
  end

  add_index "reviews", ["client_id"], name: "index_reviews_on_client_id", using: :btree
  add_index "reviews", ["masseur_id"], name: "index_reviews_on_masseur_id", using: :btree

  create_table "services", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sexual_orientations", force: :cascade do |t|
    t.string   "orientation"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "site_setting_logs", force: :cascade do |t|
    t.text     "site_changes"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "site_settings", force: :cascade do |t|
    t.float    "basic_package_price"
    t.float    "premium_package_price"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.boolean  "approval_required_for_new_masseurs", default: true
    t.integer  "advertise_page"
    t.integer  "privacy_page"
    t.integer  "tos_page"
    t.text     "payment_address"
    t.string   "admin_notification_email"
    t.text     "keywords"
    t.text     "badge_disclaimer"
    t.boolean  "approval_required_for_new_clients",  default: true
  end

  create_table "smoking_frequencies", force: :cascade do |t|
    t.string   "frequency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "static_page_translations", force: :cascade do |t|
    t.integer  "static_page_id", null: false
    t.string   "locale",         null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "title"
    t.text     "content"
    t.string   "slug"
  end

  add_index "static_page_translations", ["locale"], name: "index_static_page_translations_on_locale", using: :btree
  add_index "static_page_translations", ["static_page_id"], name: "index_static_page_translations_on_static_page_id", using: :btree

  create_table "static_pages", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  create_table "subscription_transactions", force: :cascade do |t|
    t.integer  "subscription_id"
    t.float    "amount_charged"
    t.boolean  "success"
    t.text     "serialized_response"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "cc_last_four"
    t.string   "card_brand"
  end

  add_index "subscription_transactions", ["subscription_id"], name: "index_subscription_transactions_on_subscription_id", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "masseur_id"
    t.integer  "promo_code_id"
    t.integer  "subscription_type"
    t.boolean  "active"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "gateway_subscription_id"
  end

  add_index "subscriptions", ["masseur_id"], name: "index_subscriptions_on_masseur_id", using: :btree
  add_index "subscriptions", ["promo_code_id"], name: "index_subscriptions_on_promo_code_id", using: :btree

  create_table "tracking_links", force: :cascade do |t|
    t.string   "code"
    t.string   "source"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "converted",         default: false
    t.datetime "converted_at"
    t.text     "notes"
    t.integer  "promo_code_id"
    t.boolean  "should_pop_signup", default: false
  end

  add_index "tracking_links", ["promo_code_id"], name: "index_tracking_links_on_promo_code_id", using: :btree

  create_table "travel_ads", force: :cascade do |t|
    t.integer  "masseur_id"
    t.integer  "massage_type_id"
    t.text     "about_me"
    t.text     "about_my_services"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.date     "start_date"
    t.date     "end_date"
  end

  add_index "travel_ads", ["massage_type_id"], name: "index_travel_ads_on_massage_type_id", using: :btree
  add_index "travel_ads", ["masseur_id"], name: "index_travel_ads_on_masseur_id", using: :btree

  create_table "trials", force: :cascade do |t|
    t.integer  "masseur_id"
    t.integer  "promo_code_id"
    t.integer  "subscription_type"
    t.boolean  "active"
    t.boolean  "fourteen_day_email_sent"
    t.boolean  "seven_day_email_sent"
    t.datetime "ends_at"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "trials", ["masseur_id"], name: "index_trials_on_masseur_id", using: :btree
  add_index "trials", ["promo_code_id"], name: "index_trials_on_promo_code_id", using: :btree

  create_table "work_locations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "work_surfaces", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "ad_photos", "ads"
  add_foreign_key "ad_photos", "photos"
  add_foreign_key "ad_photos", "travel_ads"
  add_foreign_key "ads", "massage_types"
  add_foreign_key "ads", "masseurs"
  add_foreign_key "favorites", "clients"
  add_foreign_key "favorites", "masseurs"
  add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", column: "conversation_id", name: "mb_opt_outs_on_conversations_id"
  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", column: "conversation_id", name: "notifications_on_conversation_id"
  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", column: "notification_id", name: "receipts_on_notification_id"
  add_foreign_key "masseur_details", "body_hairs"
  add_foreign_key "masseur_details", "builds"
  add_foreign_key "masseur_details", "drug_frequencies"
  add_foreign_key "masseur_details", "ethnicities"
  add_foreign_key "masseur_details", "eye_colors"
  add_foreign_key "masseur_details", "hair_colors"
  add_foreign_key "masseur_details", "masseurs"
  add_foreign_key "masseur_details", "sexual_orientations"
  add_foreign_key "masseur_details", "smoking_frequencies"
  add_foreign_key "masseur_documentations", "masseurs"
  add_foreign_key "masseur_languages", "languages"
  add_foreign_key "masseur_languages", "masseur_details"
  add_foreign_key "masseurs", "tracking_links"
  add_foreign_key "photos", "masseurs"
  add_foreign_key "rates", "masseur_details"
  add_foreign_key "reviews", "clients"
  add_foreign_key "reviews", "masseurs"
  add_foreign_key "subscription_transactions", "subscriptions"
  add_foreign_key "subscriptions", "masseurs"
  add_foreign_key "subscriptions", "promo_codes"
  add_foreign_key "tracking_links", "promo_codes"
  add_foreign_key "travel_ads", "massage_types"
  add_foreign_key "travel_ads", "masseurs"
  add_foreign_key "trials", "masseurs"
  add_foreign_key "trials", "promo_codes"
end
