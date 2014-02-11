class PaypalWorker
  include Sidekiq::Worker

  def perform(tran_id)
    @transaction = Transaction.find(tran_id)

    @paypal = PaypalInterface::Request.new(@transaction)
    @paypal.do_express_checkout
  end
end