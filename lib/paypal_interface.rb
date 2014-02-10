module PaypalInterface
  def self.send_money(email, amount, options = {})
    credentials = {
    "USER" => "adam.robbie-facilitator_api1.gmail.com",
    "PWD" => "1392049957",
    "SIGNATURE" => "AolubZXrkCc.G0pObQvoNEIufiqYAZRUInVeji8ItXT52NwtpWZKbgvc",
    }

    params = {
      "METHOD" => "MassPay",
      "CURRENCYCODE" => "USD",
      "RECEIVERTYPE" => "EmailAddress",
      "L_EMAIL0" => email,
      "L_AMT0" => ((amount.to_i)/100.to_f).to_s,
      "VERSION" => "90"
    }

    endpoint = Rails.env == 'production' ? "https://api-3t.paypal.com" : "https://api-3t.sandbox.paypal.com"
    url = URI.parse(endpoint)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    all_params = credentials.merge(params)
    stringified_params = all_params.collect { |tuple| "#{tuple.first}=#{CGI.escape(tuple.last)}" }.join("&")

    response = http.post("/nvp", stringified_params)
  end
end