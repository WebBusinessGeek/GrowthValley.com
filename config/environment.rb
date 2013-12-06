# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
GrowthValley::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => ENV['MAILER_USERNAME'],
  :password => ENV['MAILER_PWD'],
  :address => 'smtp.mailgun.org',
  :port => 587,
  :authentication => :plain,
  :domain => "idifysolutions.com",
}
