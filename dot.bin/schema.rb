# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120111151713) do

  create_table "acp_payment_transactions", :force => true do |t|
    t.decimal  "amount",        :precision => 10, :scale => 2
    t.string   "action"
    t.boolean  "success"
    t.string   "authorization"
    t.string   "message"
    t.text     "params"
    t.integer  "payment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "acp_payments", :force => true do |t|
    t.decimal  "amount",               :precision => 10, :scale => 2
    t.string   "state"
    t.integer  "user_id"
    t.integer  "company_id"
    t.string   "currency"
    t.string   "params"
    t.string   "message"
    t.string   "provider"
    t.integer  "affiliate_network_id"
    t.string   "ip"
    t.string   "transactionid"
    t.decimal  "transaction_cost",     :precision => 10, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "acp_tolk_locales", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "acp_tolk_locales", ["name"], :name => "index_acp_tolk_locales_on_name", :unique => true

  create_table "acp_tolk_phrases", :force => true do |t|
    t.text     "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "acp_tolk_translations", :force => true do |t|
    t.integer  "phrase_id"
    t.integer  "locale_id"
    t.text     "text"
    t.text     "previous_text"
    t.boolean  "primary_updated", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "acp_tolk_translations", ["phrase_id", "locale_id"], :name => "index_acp_tolk_translations_on_phrase_id_and_locale_id", :unique => true

  create_table "acp_users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "firstname"
    t.string   "lastname"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "language"
  end

  add_index "acp_users", ["confirmation_token"], :name => "index_acp_users_on_confirmation_token", :unique => true
  add_index "acp_users", ["email"], :name => "index_acp_users_on_email", :unique => true
  add_index "acp_users", ["reset_password_token"], :name => "index_acp_users_on_reset_password_token", :unique => true

  create_table "additional_regions", :force => true do |t|
    t.integer  "program_region_id",                   :null => false
    t.integer  "country_id",                          :null => false
    t.integer  "language_id",                         :null => false
    t.boolean  "enabled",           :default => true, :null => false
    t.datetime "deleted_at"
  end

  add_index "additional_regions", ["country_id"], :name => "index_additional_regions_on_country_id"
  add_index "additional_regions", ["deleted_at", "enabled", "program_region_id"], :name => "index_additional_regions_on_deleted_at"
  add_index "additional_regions", ["language_id"], :name => "index_additional_regions_on_language_id"
  add_index "additional_regions", ["program_region_id"], :name => "index_additional_regions_on_program_region_id"

  create_table "advertisers", :force => true do |t|
    t.integer  "affiliate_network_id",                                                     :null => false
    t.string   "name",                                                                     :null => false
    t.datetime "end_date"
    t.boolean  "enabled",                                                :default => true, :null => false
    t.string   "url",                                                                      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "revokement_quote",        :precision => 5,  :scale => 2
    t.integer  "revokement_quote_source",                                :default => 0
    t.datetime "deleted_at"
    t.integer  "company_id"
    t.decimal  "balance",                 :precision => 10, :scale => 2, :default => 0.0,  :null => false
  end

  add_index "advertisers", ["affiliate_network_id"], :name => "index_advertisers_on_affiliate_network_id"
  add_index "advertisers", ["deleted_at", "enabled", "end_date", "id"], :name => "index_advertisers_on_deleted_at"

  create_table "advertising_materials", :force => true do |t|
    t.integer  "landing_page_id",                                   :null => false
    t.boolean  "enabled",                         :default => true, :null => false
    t.string   "program_url",     :limit => 1024
    t.text     "image_tag"
    t.integer  "image_width"
    t.integer  "image_height"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "advertising_materials", ["deleted_at"], :name => "index_advertising_materials_on_deleted_at"
  add_index "advertising_materials", ["landing_page_id"], :name => "index_advertising_materials_on_landing_page_id"

  create_table "affiliate_networks", :force => true do |t|
    t.string   "name",                                                                     :null => false
    t.string   "statistic_grabber"
    t.boolean  "enabled",                                               :default => true,  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "provision",               :precision => 5, :scale => 2
    t.datetime "deleted_at"
    t.string   "type"
    t.boolean  "direct_payment_provider",                               :default => false
    t.boolean  "callback_enabled"
  end

  add_index "affiliate_networks", ["deleted_at"], :name => "index_affiliate_networks_on_deleted_at"

  create_table "allopass_working_prices", :force => true do |t|
    t.string   "country_code"
    t.integer  "pricepoint_id"
    t.string   "payment_type"
    t.string   "buy_url"
    t.decimal  "price_amount",              :precision => 10, :scale => 4
    t.integer  "price_amount_in_cents"
    t.string   "price_reference_amount"
    t.string   "price_reference_currency"
    t.decimal  "price_exchange",            :precision => 10, :scale => 4
    t.string   "price_currency"
    t.decimal  "payout_amount",             :precision => 10, :scale => 4
    t.integer  "payout_amount_in_cents"
    t.string   "payout_reference_amount"
    t.string   "payout_reference_currency"
    t.decimal  "payout_exchange",           :precision => 10, :scale => 4
    t.string   "payout_currency"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "discrete",                                                 :default => false
  end

  create_table "app_icons", :force => true do |t|
    t.string   "appid"
    t.string   "icon"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "application_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "application_categories_applications", :id => false, :force => true do |t|
    t.integer "application_id"
    t.integer "application_category_id"
  end

  create_table "application_payment_methods", :force => true do |t|
    t.integer  "application_id"
    t.string   "country_code"
    t.string   "name"
    t.string   "identifier"
    t.integer  "affiliate_network_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",             :default => 0
    t.string   "provider"
  end

  add_index "application_payment_methods", ["application_id", "country_code"], :name => "index_apm_on_application_id_and_country_code"

  create_table "applications", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "callback_url"
    t.integer  "social_network_id"
    t.integer  "company_id"
    t.integer  "virtual_currency_id"
    t.integer  "whitelist_id"
    t.integer  "blacklist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "callback_token"
    t.datetime "deleted_at"
    t.integer  "default_filter_country_id"
    t.boolean  "direct_payment_enabled",                  :default => false
    t.text     "custom_styles"
    t.string   "apigeo_key",                :limit => 40
    t.boolean  "enabled",                                 :default => true
    t.boolean  "mobile_offer_feed_enabled"
    t.string   "apifeedkey",                :limit => 40
    t.boolean  "managed_virtual_currency"
  end

  create_table "assets", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "description"
    t.integer  "width"
    t.integer  "height"
  end

  create_table "billing_methods", :force => true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.decimal  "revenue_share",                    :precision => 5, :scale => 2
    t.decimal  "revenue_share_buffer",             :precision => 5, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "revenue_share_usd",                :precision => 5, :scale => 2
    t.decimal  "revenue_bonus",                    :precision => 5, :scale => 2
    t.decimal  "revenue_share_mobile",             :precision => 5, :scale => 2
    t.decimal  "revenue_share_usd_mobile",         :precision => 5, :scale => 2
    t.decimal  "revenue_share_buffer_mobile",      :precision => 5, :scale => 2
    t.decimal  "revenue_bonus_mobile",             :precision => 5, :scale => 2
    t.decimal  "revenue_share_brandengage",        :precision => 5, :scale => 2
    t.decimal  "revenue_share_usd_brandengage",    :precision => 5, :scale => 2
    t.decimal  "revenue_share_buffer_brandengage", :precision => 5, :scale => 2
    t.decimal  "revenue_bonus_brandengage",        :precision => 5, :scale => 2
  end

  create_table "blocked_offers", :force => true do |t|
    t.integer  "application_id"
    t.integer  "landing_page_id"
    t.string   "country_code",     :limit => 3
    t.string   "language_code",    :limit => 3
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "reason"
    t.integer  "user_id"
    t.datetime "date_of_blocking"
  end

  add_index "blocked_offers", ["application_id", "landing_page_id", "country_code", "language_code"], :name => "app_lp_cc_lc_are_unique", :unique => true
  add_index "blocked_offers", ["application_id", "landing_page_id"], :name => "index_blocked_offers_on_application_id_and_landing_page_id"
  add_index "blocked_offers", ["application_id"], :name => "index_blocked_offers_on_application_id"

  create_table "categories", :force => true do |t|
    t.string   "name",                          :null => false
    t.boolean  "enabled",    :default => true
    t.datetime "deleted_at"
    t.boolean  "greedy",     :default => false
  end

  add_index "categories", ["deleted_at"], :name => "index_categories_on_deleted_at"

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "street"
    t.string   "zip"
    t.string   "city"
    t.string   "country"
    t.string   "phone"
    t.boolean  "whitelisting_enabled",                                           :default => false
    t.boolean  "enabled",                                                        :default => false
    t.string   "filter_type",                                                    :default => "account"
    t.integer  "whitelist_id"
    t.integer  "blacklist_id"
    t.decimal  "revenue_share",                    :precision => 5, :scale => 2, :default => 30.0
    t.decimal  "revenue_share_buffer",             :precision => 5, :scale => 2, :default => 2.5
    t.string   "billing_method",                                                 :default => "margin_buffer"
    t.boolean  "greedy",                                                         :default => true
    t.integer  "default_filter_country_id"
    t.boolean  "direct_payment_enabled",                                         :default => false
    t.string   "business_contact_gender"
    t.string   "business_contact_firstname"
    t.string   "business_contact_lastname"
    t.string   "business_contact_email"
    t.string   "technical_contact_gender"
    t.string   "technical_contact_firstname"
    t.string   "technical_contact_lastname"
    t.string   "technical_contact_email"
    t.string   "website"
    t.string   "customerid"
    t.string   "hash_secret"
    t.integer  "sales_manager_id"
    t.integer  "account_manager_id"
    t.string   "competitors"
    t.string   "username"
    t.string   "password"
    t.text     "comment"
    t.decimal  "revenue_share_usd",                :precision => 5, :scale => 2
    t.decimal  "revenue_bonus",                    :precision => 5, :scale => 2
    t.string   "timezone"
    t.decimal  "expected_revenue",                 :precision => 9, :scale => 2
    t.boolean  "truncate_virtual_currency",                                      :default => true
    t.boolean  "is_publisher"
    t.boolean  "is_advertiser"
    t.decimal  "revenue_share_mobile",             :precision => 5, :scale => 2, :default => 30.0
    t.decimal  "revenue_share_usd_mobile",         :precision => 5, :scale => 2
    t.decimal  "revenue_share_buffer_mobile",      :precision => 5, :scale => 2, :default => 1.0
    t.decimal  "revenue_bonus_mobile",             :precision => 5, :scale => 2
    t.decimal  "revenue_share_brandengage",        :precision => 5, :scale => 2, :default => 30.0
    t.decimal  "revenue_share_usd_brandengage",    :precision => 5, :scale => 2
    t.decimal  "revenue_share_buffer_brandengage", :precision => 5, :scale => 2, :default => 1.0
    t.decimal  "revenue_bonus_brandengage",        :precision => 5, :scale => 2
  end

  create_table "content_translations", :force => true do |t|
    t.integer  "content_id"
    t.string   "locale"
    t.text     "text_in_revision"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contents", :force => true do |t|
    t.text     "text",                                     :null => false
    t.text     "text_in_revision"
    t.integer  "author_id"
    t.integer  "author_in_revision_id"
    t.integer  "line_id"
    t.integer  "position",              :default => 0,     :null => false
    t.boolean  "visible",               :default => false, :null => false
    t.integer  "lock_version",          :default => 0,     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "template_file"
    t.boolean  "editable",              :default => true,  :null => false
    t.string   "name"
  end

  create_table "countries", :force => true do |t|
    t.string "name",              :null => false
    t.string "code", :limit => 2, :null => false
  end

  add_index "countries", ["code"], :name => "index_countries_on_code", :unique => true

  create_table "country_languages", :force => true do |t|
    t.integer "language_id",                               :null => false
    t.integer "country_id",                                :null => false
    t.boolean "visible_in_frontend",    :default => false, :null => false
    t.boolean "visible_in_translation", :default => false, :null => false
    t.integer "country_position",       :default => 1,     :null => false
    t.integer "language_position",      :default => 1,     :null => false
  end

  add_index "country_languages", ["country_id", "language_position"], :name => "index_country_languages_on_country_id_and_language_position", :unique => true
  add_index "country_languages", ["country_id"], :name => "index_country_languages_on_country_id"
  add_index "country_languages", ["language_id", "country_id"], :name => "index_country_languages_on_language_id_and_country_id", :unique => true
  add_index "country_languages", ["language_id", "country_position"], :name => "index_country_languages_on_language_id_and_country_position", :unique => true
  add_index "country_languages", ["language_id"], :name => "index_country_languages_on_language_id"

  create_table "country_routes", :force => true do |t|
    t.integer "country_id"
    t.integer "application_id"
    t.integer "offerwall"
    t.integer "interstitial"
  end

  create_table "currencies", :force => true do |t|
    t.string   "currency",   :limit => 3,                                :default => "",  :null => false
    t.decimal  "rate",                    :precision => 13, :scale => 6, :default => 1.0, :null => false
    t.datetime "updated_at"
  end

  add_index "currencies", ["currency"], :name => "index_currency_on_currency"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delivery_areas", :force => true do |t|
    t.integer  "direct_payment_method_id"
    t.integer  "country_id"
    t.boolean  "enabled",                  :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "demographies", :id => false, :force => true do |t|
    t.integer "application_id",                :null => false
    t.integer "year",                          :null => false
    t.integer "gender",                        :null => false
    t.integer "counter",        :default => 0, :null => false
  end

  add_index "demographies", ["application_id", "year", "gender"], :name => "index_demographies_on_application_id_and_year_and_gender", :unique => true

  create_table "direct_payment_default_pricepoints", :force => true do |t|
    t.decimal "amount",              :precision => 10, :scale => 2
    t.decimal "virtual_amount",      :precision => 10, :scale => 2
    t.integer "virtual_currency_id"
  end

  add_index "direct_payment_default_pricepoints", ["virtual_currency_id"], :name => "index_direct_payment_default_pricepoints_on_virtual_currency_id"

  create_table "direct_payment_method_activations", :force => true do |t|
    t.integer  "application_id"
    t.integer  "direct_payment_method_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "direct_payment_method_activations", ["application_id", "direct_payment_method_id"], :name => "uniq_index", :unique => true

  create_table "direct_payment_methods", :force => true do |t|
    t.string   "identifier"
    t.string   "name"
    t.text     "description"
    t.decimal  "default_revenue_share", :precision => 5, :scale => 2
    t.boolean  "enabled",                                             :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",                                            :default => 0
    t.string   "provider"
    t.boolean  "mobile",                                              :default => false
    t.float    "fraud_limit"
    t.float    "fraud_score"
  end

  create_table "direct_payment_subscriptions", :force => true do |t|
    t.integer  "company_id"
    t.integer  "direct_payment_method_id"
    t.decimal  "revenue_share",            :precision => 5, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "enabled",                                                :default => true
  end

  create_table "filter_chains", :force => true do |t|
    t.string  "name"
    t.string  "status"
    t.string  "action"
    t.integer "position",      :default => 0,     :null => false
    t.integer "criteria_id"
    t.integer "parent_id"
    t.string  "criteria_type"
    t.boolean "catch_all",     :default => false, :null => false
  end

  add_index "filter_chains", ["parent_id"], :name => "index_filter_chains_on_parent_id"

  create_table "filter_elements", :force => true do |t|
    t.integer  "offer_filter_id"
    t.integer  "element_id"
    t.string   "element_type"
    t.boolean  "selected"
    t.date     "seen_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "filter_elements", ["offer_filter_id", "selected", "element_id"], :name => "index_fe_on_offer_filter"

  create_table "fixed_price_points", :force => true do |t|
    t.integer  "application_id"
    t.integer  "country_id"
    t.decimal  "floor",          :precision => 10, :scale => 2
    t.decimal  "ceiling",        :precision => 10, :scale => 2
    t.decimal  "reward",         :precision => 10, :scale => 2
    t.string   "incentive"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fraud_limits", :force => true do |t|
    t.float    "limit"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "iframe_data_sources", :id => false, :force => true do |t|
    t.integer  "publisher_id"
    t.integer  "application_id"
    t.integer  "affiliate_network_id"
    t.integer  "advertiser_id"
    t.integer  "program_id"
    t.integer  "landing_page_id"
    t.integer  "advertising_material_id"
    t.integer  "provision_id"
    t.string   "group_name"
    t.integer  "effort",                                                                     :default => 0,     :null => false
    t.integer  "no_of_text_fields"
    t.datetime "end_date"
    t.decimal  "revokement_quote",                            :precision => 5,  :scale => 2
    t.decimal  "conversion",                                  :precision => 5,  :scale => 2
    t.string   "title",                                                                      :default => "",    :null => false
    t.text     "teaser",                                                                                        :null => false
    t.text     "required_actions",                                                                              :null => false
    t.text     "required_actions_long"
    t.string   "program_url",                 :limit => 1024,                                :default => "",    :null => false
    t.text     "image_tag"
    t.integer  "image_width"
    t.integer  "image_height"
    t.integer  "method_of_payment",                                                          :default => 0,     :null => false
    t.integer  "latency",                                                                    :default => 0
    t.integer  "contingent",                                                                 :default => 0
    t.integer  "leads_per_user",                                                             :default => 0
    t.integer  "minimum_age"
    t.string   "tracking_type"
    t.integer  "target_reach"
    t.string   "virtual_currency"
    t.decimal  "reward",                                      :precision => 10, :scale => 2
    t.boolean  "popular"
    t.string   "country_code",                :limit => 3
    t.string   "language_code",               :limit => 3
    t.integer  "priority"
    t.boolean  "high_reward",                                                                :default => false
    t.string   "callback_url"
    t.string   "callback_token"
    t.decimal  "publisher_payout_euro",                       :precision => 10, :scale => 4
    t.string   "original_provision_currency"
    t.decimal  "original_provision_value",                    :precision => 10, :scale => 2
    t.float    "exchange_rate_to_euro"
    t.string   "cp_model"
    t.integer  "run_dmc"
    t.integer  "run_lsd"
    t.boolean  "is_new",                                                                     :default => false
    t.decimal  "revenue_share",                               :precision => 5,  :scale => 2
    t.decimal  "publisher_payout_usd",                        :precision => 10, :scale => 4
    t.float    "fraud_score",                                                                :default => 0.0
    t.float    "fraud_limit",                                                                :default => 100.0
  end

  add_index "iframe_data_sources", ["advertiser_id"], :name => "index_iframe_data_sources_on_advertiser_id"
  add_index "iframe_data_sources", ["advertising_material_id", "provision_id"], :name => "iframe_data_source_index_prov_ad_material"
  add_index "iframe_data_sources", ["advertising_material_id"], :name => "index_iframe_data_sources_on_advertising_material_id"
  add_index "iframe_data_sources", ["affiliate_network_id"], :name => "index_iframe_data_sources_on_affiliate_network_id"
  add_index "iframe_data_sources", ["application_id", "country_code", "language_code", "landing_page_id"], :name => "unique_key_on_iframe_data_sources", :unique => true
  add_index "iframe_data_sources", ["application_id"], :name => "index_iframe_data_sources_on_application_id"
  add_index "iframe_data_sources", ["landing_page_id"], :name => "index_iframe_data_sources_on_landing_page_id"
  add_index "iframe_data_sources", ["program_id"], :name => "index_iframe_data_sources_on_program_id"
  add_index "iframe_data_sources", ["provision_id"], :name => "index_iframe_data_sources_on_provision_id"
  add_index "iframe_data_sources", ["publisher_id"], :name => "index_iframe_data_sources_on_publisher_id"

  create_table "iframe_export_histories", :force => true do |t|
    t.integer  "landing_page_id", :null => false
    t.integer  "application_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "iframe_export_histories", ["landing_page_id", "application_id"], :name => "ieh_lp_id_app_id_index", :unique => true

  create_table "industries", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "deleted_at"
  end

  add_index "industries", ["deleted_at"], :name => "index_industries_on_deleted_at"

  create_table "landing_pages", :force => true do |t|
    t.integer  "program_region_id",                                                                            :null => false
    t.boolean  "enabled",                                                                   :default => true,  :null => false
    t.string   "program_url",                :limit => 1024,                                                   :null => false
    t.integer  "effort",                                                                    :default => 0,     :null => false
    t.integer  "no_of_text_fields"
    t.datetime "end_date"
    t.boolean  "double_opt_in",                                                             :default => false, :null => false
    t.decimal  "revokement_quote",                           :precision => 5,  :scale => 2
    t.decimal  "ephc_90",                                    :precision => 10, :scale => 2
    t.decimal  "conversion",                                 :precision => 5,  :scale => 2
    t.string   "title",                                                                                        :null => false
    t.text     "teaser",                                                                                       :null => false
    t.text     "required_actions",                                                                             :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "required_actions_long"
    t.boolean  "premium_brand",                                                             :default => false, :null => false
    t.integer  "priority"
    t.decimal  "epc",                                        :precision => 5,  :scale => 2
    t.integer  "method_of_payment",                                                         :default => 0,     :null => false
    t.text     "required_actions_en"
    t.datetime "deleted_at"
    t.float    "fraud_score",                                                               :default => 0.0
    t.integer  "fraud_limit_id",                                                            :default => 1
    t.boolean  "multiple_completitions",                                                    :default => false
    t.text     "application_whitelist"
    t.string   "affiliate_callback_url"
    t.boolean  "video_offer"
    t.text     "video_url"
    t.string   "clickthrough_text"
    t.string   "banner_url"
    t.text     "video_share_url"
    t.boolean  "widget",                                                                    :default => false
    t.string   "brand_banner_url"
    t.integer  "video_type"
    t.boolean  "groupon_offer"
    t.text     "widget_title"
    t.text     "widget_description"
    t.boolean  "campaign",                                                                  :default => false
    t.string   "campaign_img_url"
    t.boolean  "web_offer",                                                                 :default => true
    t.boolean  "ios_offer"
    t.boolean  "android_offer"
    t.string   "mobile_title"
    t.string   "mobile_teaser"
    t.string   "mobile_required_action"
    t.boolean  "demographically_targeted",                                                  :default => false, :null => false
    t.integer  "demograph_age_min"
    t.integer  "demograph_age_max"
    t.string   "demograph_gender",           :limit => 1,                                   :default => "a",   :null => false
    t.text     "demographics_apps"
    t.integer  "video_duration",                                                            :default => 0
    t.boolean  "mobile_interstitial",                                                       :default => false
    t.boolean  "mobile_campaign",                                                           :default => false
    t.boolean  "testoffer",                                                                 :default => false
    t.boolean  "geo_target",                                                                :default => false
    t.float    "geo_longitude"
    t.float    "geo_latitude"
    t.float    "geo_radius"
    t.text     "video_snippet"
    t.integer  "video_pay_type"
    t.integer  "video_width"
    t.integer  "video_height"
    t.integer  "mc_velocity"
    t.integer  "required_landing_page_id"
    t.decimal  "app_price",                                  :precision => 5,  :scale => 2, :default => 0.0
    t.string   "unique_identifier"
    t.string   "mobile_required_action_tag"
    t.text     "completed_lpids"
  end

  add_index "landing_pages", ["deleted_at"], :name => "index_landing_pages_on_deleted_at"
  add_index "landing_pages", ["program_region_id"], :name => "index_landing_pages_on_program_region_id"

  create_table "language_translations", :force => true do |t|
    t.integer  "language_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "languages", :force => true do |t|
    t.string  "locale",                                                 :null => false
    t.string  "name",                                                   :null => false
    t.boolean "visible_in_frontend",                 :default => false, :null => false
    t.boolean "visible_in_translation",              :default => false, :null => false
    t.string  "code",                   :limit => 3,                    :null => false
  end

  add_index "languages", ["code"], :name => "index_languages_on_code", :unique => true
  add_index "languages", ["locale"], :name => "languages_locale_unqiue", :unique => true

  create_table "lines", :force => true do |t|
    t.integer  "page_id"
    t.string   "line_type",     :default => "",   :null => false
    t.integer  "position",      :default => 0,    :null => false
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "template_file"
    t.boolean  "editable",      :default => true, :null => false
    t.boolean  "visible",       :default => true
  end

  create_table "mail_content_translations", :force => true do |t|
    t.integer  "mail_content_id"
    t.string   "locale"
    t.string   "subject_in_revision"
    t.text     "body_in_revision"
    t.text     "body"
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mail_contents", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "subject"
    t.string   "subject_in_revision"
    t.text     "body"
    t.text     "body_in_revision"
    t.integer  "author_id"
    t.integer  "author_in_revision_id"
    t.integer  "lock_version",          :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mail_variables", :force => true do |t|
    t.integer  "mail_content_id"
    t.string   "name"
    t.string   "value"
    t.string   "default_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "media_translations", :force => true do |t|
    t.integer  "media_id"
    t.string   "locale"
    t.string   "source_in_revision"
    t.string   "source"
    t.string   "title"
    t.string   "title_in_revision"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medias", :force => true do |t|
    t.string   "title"
    t.string   "title_in_revision"
    t.integer  "author_id"
    t.integer  "author_in_revision_id"
    t.integer  "lock_version",          :default => 0,     :null => false
    t.boolean  "visible",               :default => false, :null => false
    t.string   "media_type"
    t.string   "source"
    t.string   "source_in_revision"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "original_file_name"
  end

  create_table "meta_data_translations", :force => true do |t|
    t.integer  "meta_data_id"
    t.string   "locale"
    t.text     "description_in_revision"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meta_datas", :force => true do |t|
    t.string   "key"
    t.text     "description"
    t.integer  "author_id"
    t.integer  "author_in_revision_id"
    t.text     "description_in_revision"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "page_id"
  end

  create_table "offer_filters", :force => true do |t|
    t.integer  "country_id"
    t.string   "filter_type"
    t.integer  "filterer_id"
    t.string   "filterer_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "offer_filters", ["filter_type", "filterer_type"], :name => "index_of_on_f_type_and_f_type"
  add_index "offer_filters", ["filterer_type", "filterer_id"], :name => "index_of_on_f_id_and_f_type"

  create_table "offer_priority_lists", :force => true do |t|
    t.string  "country_id",     :null => false
    t.integer "application_id", :null => false
    t.text    "offers"
    t.text    "offers_last"
    t.date    "updated_at"
  end

  add_index "offer_priority_lists", ["application_id", "country_id"], :name => "index_offer_priority_lists_on_application_id_and_country_id", :unique => true

  create_table "offers_versions", :primary_key => "country_id", :force => true do |t|
    t.integer "version"
  end

  create_table "offerwall_callbacks", :force => true do |t|
    t.boolean "enabled",         :default => true
    t.integer "landing_page_id"
    t.integer "callback_type"
    t.integer "position"
    t.text    "url"
  end

  add_index "offerwall_callbacks", ["landing_page_id", "callback_type"], :name => "index_offerwall_callbacks_on_landing_page_id_and_callback_type"

  create_table "page_sidebars", :force => true do |t|
    t.integer  "page_id"
    t.integer  "sidebar_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "page_sidebars", ["page_id"], :name => "index_page_sidebars_on_page_id"
  add_index "page_sidebars", ["sidebar_id"], :name => "index_page_sidebars_on_sidebar_id"

  create_table "page_translations", :force => true do |t|
    t.integer  "page_id"
    t.string   "locale"
    t.text     "description_in_revision"
    t.string   "title"
    t.text     "description"
    t.string   "title_in_revision"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.integer  "parent_id"
    t.boolean  "show_sidebar",            :default => false, :null => false
    t.boolean  "visible",                 :default => false, :null => false
    t.boolean  "table_of_contents",       :default => false, :null => false
    t.text     "description"
    t.text     "description_in_revision"
    t.integer  "author_id"
    t.integer  "author_in_revision_id"
    t.string   "title",                   :default => "",    :null => false
    t.string   "title_in_revision"
    t.integer  "position"
    t.integer  "lock_version",            :default => 0,     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "sidebar_position"
    t.string   "sidebar_size"
    t.string   "template_file"
    t.boolean  "editable",                :default => true,  :null => false
  end

  add_index "pages", ["name"], :name => "index_pages_on_name", :unique => true

  create_table "payment_data_sources", :force => true do |t|
    t.integer  "application_payment_method_id"
    t.string   "currency"
    t.decimal  "amount",                        :precision => 10, :scale => 2
    t.decimal  "reward",                        :precision => 10, :scale => 2
    t.decimal  "publisher_payout_euro",         :precision => 10, :scale => 4
    t.decimal  "publisher_payout_usd",          :precision => 10, :scale => 4
    t.float    "exchange_rate_to_euro"
    t.decimal  "revenue_share",                 :precision => 5,  :scale => 2
    t.string   "callback_url"
    t.string   "callback_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "transaction_cost",              :precision => 10, :scale => 2
  end

  add_index "payment_data_sources", ["application_payment_method_id"], :name => "index_payment_data_sources_on_application_payment_method_id"

  create_table "payment_infos", :force => true do |t|
    t.integer  "company_id"
    t.string   "payment_type"
    t.string   "country"
    t.string   "beneficiary_name"
    t.string   "bank_name"
    t.string   "bank_address"
    t.string   "account_identification_type"
    t.string   "iban"
    t.string   "bic"
    t.string   "bban"
    t.string   "bin"
    t.string   "paypal_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "payout_currency",             :limit => 3, :default => "EUR", :null => false
    t.string   "vat"
    t.string   "billing_email"
    t.string   "billing_firstname"
    t.string   "billing_lastname"
    t.string   "billing_gender"
    t.integer  "payout_times"
    t.string   "payout_terms"
  end

  add_index "payment_infos", ["company_id"], :name => "index_payment_infos_on_company_id"

  create_table "prelaunches", :force => true do |t|
    t.string   "email"
    t.boolean  "activated",              :default => false, :null => false
    t.string   "code",                   :default => "",    :null => false
    t.boolean  "newsletter",             :default => false, :null => false
    t.boolean  "asked_for_newsletter",   :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "ordered_prelaunch_code", :default => false, :null => false
    t.string   "locale"
  end

  create_table "price_point_activations", :force => true do |t|
    t.integer  "application_id"
    t.integer  "price_point_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "price_point_activations", ["application_id", "price_point_id"], :name => "uniq_index", :unique => true

  create_table "price_points", :force => true do |t|
    t.integer  "delivery_area_id"
    t.integer  "currency_id"
    t.decimal  "amount",           :precision => 10, :scale => 2
    t.decimal  "transaction_cost", :precision => 10, :scale => 2
    t.boolean  "enabled",                                         :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "program_categories", :force => true do |t|
    t.integer "category_id",     :null => false
    t.integer "subcategory_id"
    t.integer "landing_page_id", :null => false
  end

  add_index "program_categories", ["category_id"], :name => "index_program_categories_on_category_id"
  add_index "program_categories", ["landing_page_id", "category_id"], :name => "index_program_categories_on_landing_page_id_and_category_id"
  add_index "program_categories", ["subcategory_id"], :name => "index_program_categories_on_subcategory_id"

  create_table "program_category_restrictions", :force => true do |t|
    t.integer "program_id",     :null => false
    t.integer "category_id",    :null => false
    t.integer "subcategory_id"
  end

  add_index "program_category_restrictions", ["category_id"], :name => "index_program_category_restrictions_on_category_id"
  add_index "program_category_restrictions", ["program_id", "category_id"], :name => "index_restriction_program_id_category_id"
  add_index "program_category_restrictions", ["program_id"], :name => "index_program_category_restrictions_on_program_id"
  add_index "program_category_restrictions", ["subcategory_id"], :name => "index_program_category_restrictions_on_subcategory_id"

  create_table "program_industries", :force => true do |t|
    t.integer "industry_id",     :null => false
    t.integer "segment_id"
    t.integer "landing_page_id", :null => false
  end

  add_index "program_industries", ["industry_id"], :name => "index_program_industries_on_industry_id"
  add_index "program_industries", ["landing_page_id", "industry_id"], :name => "index_program_industries_on_landing_page_id_and_industry_id"
  add_index "program_industries", ["segment_id"], :name => "index_program_industries_on_segment_id"

  create_table "program_industry_restrictions", :force => true do |t|
    t.integer "program_id",  :null => false
    t.integer "industry_id", :null => false
    t.integer "segment_id"
  end

  add_index "program_industry_restrictions", ["industry_id"], :name => "index_program_industry_restrictions_on_industry_id"
  add_index "program_industry_restrictions", ["program_id", "industry_id"], :name => "index_restriction_program_id_industry_id"
  add_index "program_industry_restrictions", ["program_id"], :name => "index_program_industry_restrictions_on_program_id"
  add_index "program_industry_restrictions", ["segment_id"], :name => "index_program_industry_restrictions_on_segment_id"

  create_table "program_informations", :force => true do |t|
    t.integer  "program_region_id", :null => false
    t.string   "title",             :null => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "program_informations", ["deleted_at"], :name => "index_program_informations_on_deleted_at"
  add_index "program_informations", ["program_region_id", "title"], :name => "index_program_informations_on_program_region_id_and_title"
  add_index "program_informations", ["program_region_id"], :name => "index_program_informations_on_program_region_id"

  create_table "program_regions", :force => true do |t|
    t.integer  "program_id",                    :null => false
    t.integer  "country_id",                    :null => false
    t.integer  "language_id",                   :null => false
    t.boolean  "enabled",     :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "program_regions", ["country_id"], :name => "index_program_regions_on_country_id"
  add_index "program_regions", ["deleted_at"], :name => "index_program_regions_on_deleted_at"
  add_index "program_regions", ["language_id"], :name => "index_program_regions_on_language_id"
  add_index "program_regions", ["program_id"], :name => "index_program_regions_on_program_id"

  create_table "programs", :force => true do |t|
    t.string   "name",                                                                               :null => false
    t.integer  "advertiser_id",                                                                      :null => false
    t.boolean  "auto_accept",                                                     :default => true,  :null => false
    t.boolean  "enabled",                                                         :default => true,  :null => false
    t.boolean  "anonym",                                                          :default => false, :null => false
    t.integer  "latency",                                                         :default => 0
    t.integer  "contingent",                                                      :default => 0
    t.integer  "leads_per_user",                                                  :default => 0
    t.boolean  "sem_restricted",                                                  :default => false, :null => false
    t.integer  "minimum_age"
    t.string   "tracking_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "revokement_quote",                  :precision => 5, :scale => 2
    t.integer  "processing_time"
    t.string   "group_name"
    t.integer  "target_reach"
    t.integer  "application_status",                                              :default => 0,     :null => false
    t.decimal  "ecpm",                              :precision => 5, :scale => 2
    t.decimal  "epc",                               :precision => 5, :scale => 2
    t.integer  "revokement_quote_source",                                         :default => 0
    t.integer  "latency_computed"
    t.datetime "deleted_at"
    t.integer  "fb_compliance",                                                   :default => 2
    t.integer  "daily_max_clicks"
    t.integer  "daily_contingent"
    t.text     "comment"
    t.decimal  "expected_revenue",                  :precision => 9, :scale => 2
    t.integer  "account_manager_id"
    t.integer  "sales_manager_id"
    t.integer  "mobile_callbacks_counter",                                        :default => 0,     :null => false
    t.integer  "previous_mobile_callbacks_counter",                               :default => 0,     :null => false
    t.integer  "application_id"
    t.datetime "last_ping"
  end

  add_index "programs", ["advertiser_id"], :name => "index_programs_on_advertiser_id"
  add_index "programs", ["application_id"], :name => "index_programs_on_application_id"
  add_index "programs", ["deleted_at"], :name => "index_programs_on_deleted_at"

  create_table "provisions", :force => true do |t|
    t.string   "cp_model",                                                                        :null => false
    t.integer  "billingtype",                                                  :default => 0,     :null => false
    t.decimal  "value",                         :precision => 10, :scale => 4, :default => 0.0,   :null => false
    t.string   "currency",                                                     :default => "EUR", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "min_lead",                                                     :default => 0
    t.integer  "max_lead",                                                     :default => 0
    t.integer  "landing_page_id",                                                                 :null => false
    t.boolean  "payout_control"
    t.boolean  "ignore_communicated_provision",                                :default => false, :null => false
  end

  add_index "provisions", ["cp_model"], :name => "index_provisions_on_cp_model"
  add_index "provisions", ["landing_page_id"], :name => "idx_landing_page_id"
  add_index "provisions", ["landing_page_id"], :name => "index_provisions_on_lp"

  create_table "publisher_revenue_shares", :force => true do |t|
    t.integer  "application_id"
    t.decimal  "share",          :precision => 5, :scale => 2, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "publisher_revenue_shares", ["application_id"], :name => "index_publisher_revenue_shares_on_application_id"

  create_table "publisher_versions", :primary_key => "application_id", :force => true do |t|
    t.integer "company_id"
    t.integer "application_version"
    t.integer "company_version"
  end

  add_index "publisher_versions", ["company_id"], :name => "index_publisher_versions_on_company_id"

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"

  create_table "segments", :force => true do |t|
    t.string   "name",        :null => false
    t.integer  "industry_id", :null => false
    t.datetime "deleted_at"
  end

  add_index "segments", ["deleted_at"], :name => "index_segments_on_deleted_at"
  add_index "segments", ["industry_id"], :name => "index_segments_on_industry_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "sidebar_translations", :force => true do |t|
    t.integer  "sidebar_id"
    t.string   "locale"
    t.text     "text_in_revision"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sidebars", :force => true do |t|
    t.text     "text"
    t.text     "text_in_revision"
    t.integer  "author_id"
    t.integer  "author_in_revision_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "template_file"
    t.boolean  "editable",              :default => false, :null => false
    t.boolean  "visible",               :default => true,  :null => false
  end

  create_table "social_networks", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "fb_compliance", :default => false, :null => false
    t.string   "mobile_type"
  end

  create_table "static_text_translations", :force => true do |t|
    t.integer  "static_text_id"
    t.string   "locale"
    t.text     "text_in_revision"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "static_texts", :force => true do |t|
    t.string   "name"
    t.text     "text"
    t.text     "text_in_revision"
    t.integer  "author_id"
    t.integer  "author_in_revision_id"
    t.string   "namespace"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subcategories", :force => true do |t|
    t.string   "name",        :null => false
    t.integer  "category_id", :null => false
    t.datetime "deleted_at"
  end

  add_index "subcategories", ["category_id"], :name => "index_subcategories_on_category_id"
  add_index "subcategories", ["deleted_at"], :name => "index_subcategories_on_deleted_at"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "taggable_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  add_index "tags", ["name"], :name => "index_tags_on_name"

  create_table "user_infos", :force => true do |t|
    t.integer  "user_id"
    t.text     "info"
    t.datetime "date"
    t.integer  "editor_id"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.datetime "deleted_at"
    t.string   "invited_by"
    t.datetime "invited_at"
    t.datetime "registered_at"
    t.datetime "last_login_at"
    t.datetime "last_changes_at"
    t.integer  "login_count"
    t.integer  "failed_login_count"
    t.string   "language"
    t.string   "fallback_language"
    t.integer  "company_id"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "gender"
    t.string   "password_request_code"
  end

  create_table "users_languages", :id => false, :force => true do |t|
    t.integer "language_id"
    t.integer "user_id"
  end

  create_table "virtual_currencies", :force => true do |t|
    t.string   "name"
    t.float    "exchange_rate_to_euro"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "exchange_rate_to_usd"
    t.integer  "default_direct_payment_currency_id"
    t.integer  "mobile_payment_reduction"
    t.boolean  "reward_from_gross_revenue",          :default => false, :null => false
    t.boolean  "roundup_for_video",                  :default => false
  end

  create_table "zong_working_prices", :force => true do |t|
    t.boolean  "zong_plus",                                             :default => false
    t.string   "item_reference"
    t.string   "entry_point_url"
    t.decimal  "out_payment",            :precision => 10, :scale => 4
    t.decimal  "working_price",          :precision => 10, :scale => 4
    t.integer  "out_payment_in_cents"
    t.integer  "working_price_in_cents"
    t.string   "country_code"
    t.string   "currency"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "zong_working_prices", ["working_price_in_cents", "country_code"], :name => "index_zwp_on_working_price_in_cents_and_country_code"

end
