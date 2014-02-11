require 'paypal_interface'
require 'paypal-sdk-merchant'

module PaypalInterface
  class Request
    attr_reader :api, :express_checkout_response

    def initialize(transaction)
      @api = PayPal::SDK::Merchant::API.new
      @tran = transaction
    end

    def express_checkout
      @set_express_checkout = @api.build_set_express_checkout({
        SetExpressCheckoutRequestDetails: {
          ReturnURL: PAYPAL_RETURN_URL,
          CancelURL: PAYPAL_CANCEL_URL,
          PaymentDetails: [{
            NotifyURL: PAYPAL_NOTIFY_URL,
            OrderTotal: {
              currencyID: "USD",
              value: @tran.total
            },
            ItemTotal: {
              currencyID: "USD",
              value: @tran.total
            },
            ShippingTotal: {
              currencyID: "USD",
              value: "0"
            },
            TaxTotal: {
              currencyID: "USD",
              value: "0"
            },
            PaymentDetailsItem: [{
              Name: @tran.code,
              Quantity: 1,
              Amount: {
                currencyID: "USD",
                value: @tran.total
              },
              ItemCategory: "Digital"
            }],
            PaymentAction: "Sale"
          }]
        }
      })

      # Make API call & get response
      @express_checkout_response = @api.set_express_checkout(@set_express_checkout)

      # Access Response
      if @express_checkout_response.success?
        @tran.set_payment_token(@express_checkout_response.Token)
      else
        @express_checkout_response.Errors
      end
    end

    def do_express_checkout
      @do_express_checkout_payment = @api.build_do_express_checkout_payment({
        DoExpressCheckoutPaymentRequestDetails: {
          PaymentAction: "Sale",
          Token: @tran.payment_token,
          PayerID: @tran.payerID,
          PaymentDetails: [{
            OrderTotal: {
              currencyID: "USD",
              value: @tran.total
            },
            NotifyURL: PAYPAL_NOTIFY_URL
          }]
        }
      })

      # Make API call & get response
      @do_express_checkout_payment_response = @api.do_express_checkout_payment(@do_express_checkout_payment)

      # Access Response
      if @do_express_checkout_payment_response.success?
        details = @do_express_checkout_payment_response.DoExpressCheckoutPaymentResponseDetails
        @tran.set_payment_details(details)
      else
        errors = @do_express_checkout_payment_response.Errors # => Array
        @tran.save_payment_errors(errors)
      end
    end
  end
end
