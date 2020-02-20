require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module M4m
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
    
    # Include vendor assets
    config.assets.paths << Rails.root.join('vendor', 'assets', 'components')
    
    # For including models in subdirectories without namespacing them
    config.autoload_paths += Dir[Rails.root.join('app', 'models', '{**}')]
    config.assets.precompile << %w( *.scss *.js )

    # ActiveMerchant in test mode
    # ActiveMerchant::Billing::Base.mode = :test
    
    AUTHORIZE_NET_LOGIN = ""
    AUTHORIZE_NET_KEY = ""
    AUTHORIZE_NET_USE_TEST_MODE = true
    
    GOOGLE_MAPS_API_KEY = "AIzaSyDwdgehv0fY_gfln2GXkHT0P27CWxsSSHM"
  end
end
