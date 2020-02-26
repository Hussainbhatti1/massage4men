ruby '2.4.1'
source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.9'

# Use sqlite3 as the database for Active Record
#gem 'sqlite3'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Bootstrap for asset pipeline
gem 'bootstrap-sass', '~> 3.3.6'

gem 'font-awesome-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
#gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development


# All other gems
gem 'activerecord-deprecated_finders', require: 'active_record/deprecated_finders'

gem 'devise'
gem 'devise_security_extension'
gem 'rails_email_validator'
gem 'cancancan'

gem 'simple_form'
gem 'mail_form'
gem 'country_select'
gem 'carmen'
gem 'validates_timeliness'
gem "recaptcha"

gem 'paperclip'
gem 'aws-sdk'

gem 'remotipart', '~> 1.2'

gem 'bootstrap-wysihtml5-rails', git: 'https://github.com/nerian/bootstrap-wysihtml5-rails'

gem 'activemerchant', require: 'active_merchant'
gem 'credit_card_validations'

gem 'humanize_boolean'

gem 'globalize', '~> 5.0.0'
gem 'globalize-accessors'
gem 'friendly_id-globalize'

gem 'pg', '0.20'
gem 'pg_search'
# gem 'geokit'
# gem 'geokit-rails'
gem 'gmaps4rails'
gem 'world-flags', git: 'https://github.com/world-flags/world-flags.git'

gem 'unitwise'

gem 'awesome_print'

gem 'pry-rails'

# For fetching random records
gem 'randumb'

gem 'dotenv-rails', :require => 'dotenv/rails-now'
gem "recaptcha", require: "recaptcha/rails"

gem 'meta-tags'

# For pagination
gem 'kaminari'
gem 'bootstrap-kaminari-views'

gem 'resque'
gem 'resque-web', require: 'resque_web'
gem 'resque-scheduler'
gem 'resque-scheduler-web'
# gem 'active_scheduler'

gem 'jquery-slick-rails'

gem 'friendly_id', '5.2.4'

gem 'mailboxer'

gem 'impressionist'

gem 'httparty'

gem 'react-rails'

gem 'toastr-rails'

gem 'chosen-rails'
# Monitor and restart processes
gem 'eye'
gem 'eye-slack'


gem "capistrano"
gem 'capistrano-bundler'
gem 'capistrano-rvm', :require => false
# gem 'capistrano3-puma'
gem 'capistrano-rails'
gem "capistrano-db-tasks", require: false
gem 'rails_sortable'
gem 'jquery-ui-rails'

gem "geocoder"

gem 'airbrake', '~> 5.4'

gem "lazyload-rails"

gem 'ed25519', '>= 1.2', '< 2.0'
gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0'

group :development do
  gem 'capistrano-rails'
  gem 'capistrano-ssh-doctor'
  gem 'capistrano-rvm'
  gem 'capistrano-rbenv',   require: false
  gem 'capistrano-bundler'
  gem 'capistrano-resque', require: false
  gem "mailcatcher"

  # The `deploy:restart` hook for passenger applications is now in a separate gem called capistrano-passenger.  Just add it to your Gemfile and require it in your Capfile.
  # gem 'capistrano-passenger'
  # gem 'capistrano-webhook'

  gem 'web-console', '~> 2.0'
end

group :development, :test do
  gem 'byebug'
  gem 'factory_bot'
  gem 'faker'
  gem 'quiet_assets'
  gem 'rspec-rails', '~> 3.1'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'spring'
  gem "letter_opener"
  # gem 'thin' # instead of webrick
end

group :test do
  gem 'capybara'
  gem 'codeclimate-test-reporter', require: nil
end

group :production do
  gem 'rails_12factor'
end
