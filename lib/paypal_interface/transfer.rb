require 'paypal-sdk-merchant'
module PaypalInterface
  class Transfer
    attr_reader :api, :express_checkout_response

    def initialize(transaction)
      @api = PayPal::SDK::Merchant::API.new
      @transaction = transaction
    end

    def masspay
      email = @transaction.resource.teacher.paypal_email
      amount = @transaction.resource.classroom_request.amount
      @mass_pay = @api.build_mass_pay({
        :ReceiverType => "EmailAddress",
        :MassPayItem => [{
          :ReceiverEmail => email,
          :Amount => {
            :currencyID => "USD",
            :value => amount } }] })
      @mass_pay_response = @api.mass_pay(@mass_pay)
      if @mass_pay_response.Ack == "Success"
        @transaction.update_attribute(:status, "Complete")
        @transaction.create_payment(
          amount: amount,
          status: "Completed",
          data: @mass_pay_response.inspect,
          txn_id: @mas_pay_response.CorrelationID)
      else
        @api.logger.error(@mass_pay_response.Errors[0].LongMessage)
        @transaction.update_attribute(:status, "Error")
        @transaction.create_payment(
          amount: amount,
          status: "Error",
          data: @mass_pay_response.inspect,
          txn_id: @mas_pay_response.CorrelationID)
      end
      @mass_pay_response
    end
  end
end