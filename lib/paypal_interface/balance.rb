module PaypalInterface
  class Balance
    attr_reader :api, :balance_response

    def initialize
      @api = PayPal::SDK::Merchant::API.new
    end

    def balance
      build_balance = @api.build_get_balance({
        :ReturnAllCurrencies => "0" })
      @balance_response = @api.get_balance(build_balance)
      if @balance_response.success?
        @balance_response
      else
        @balance_response.Errors
      end
    end
  end
end