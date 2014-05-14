source 'https://rubygems.org'
ruby '1.9.3'

def darwin_only(require_as)
  RbConfig::CONFIG['host_os'] =~ /darwin/ && require_as
end

def linux_only(require_as)
  RbConfig::CONFIG['host_os'] =~ /linux/ && require_as
end

gem 'rails', '3.2.14'
gem 'pg'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'turbo-sprockets-rails3'
end

gem 'strong_parameters'

gem "jquery-rails", "~> 2.3.0"
gem 'therubyracer'
gem 'less-rails'
gem 'twitter-bootstrap-rails'
gem 'simple_form'
gem 'devise'
gem 'wicked'
gem 'mini_magick'
gem 'carrierwave'
gem 'figaro'
gem 'activeadmin', '~> 0.6.0'
gem 'cancan'
#gem 'stripe'
gem 'rails-rateit'
gem 'omniauth', '~> 1.1.4'
gem 'omniauth-facebook', '~> 1.4.1'
gem 'friendly_id', "~> 4.0.9"
gem 'pg_search', "~> 0.7.0"
gem "recaptcha", :require => "recaptcha/rails"
gem 'numbers_and_words'
gem 'jquery-ui-rails'
gem 'kaminari'
# Blog
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'truncate_html'
gem 'select2-rails', '~> 3.2'
gem "ckeditor"
gem 'rails_config'
# Private Classroom
gem 'activerecord-postgres-hstore'
gem 'state_machine'
gem 'acts_as_list'
# Paypal
gem 'paypal-sdk-merchant'
# Sidekiq
gem 'sidekiq'
gem 'sinatra', require: false
gem 'slim'

# Heroku
gem 'newrelic_rpm'

group :development, :test do
  gem 'rspec-rails', '~> 2.8'
  gem 'guard-rspec', '2.5.0'
  gem 'rb-inotify', '~> 0.9', :require => linux_only('rb-inotify')
  gem 'rb-fsevent', :require => darwin_only('rb-fsevent')
end

group :test do
  gem 'factory_girl_rails', '~> 1.4.0'
  gem 'capybara', '~> 1.1.4'
  gem 'capybara-webkit'
  gem 'shoulda'
  gem 'database_cleaner', '~> 0.9.1'
  gem 'launchy'
end

group :development do
  gem 'jazz_hands'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'letter_opener'
  gem 'quiet_assets'
  gem 'rack-mini-profiler'
  gem 'thin'
end

group :production do
  gem 'puma'
  gem 'rails_12factor'
end