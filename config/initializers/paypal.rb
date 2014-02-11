PayPal::SDK.load("config/paypal.yml", Rails.env)
PayPal::SDK.logger = Rails.logger
if Rails.env.production?
  HOST_WO_HTTP = 'growthvalley.herokuapp.com'
else
  HOST_WO_HTTP = 'localhost:3000'
end
HOST = "http://#{HOST_WO_HTTP}"
