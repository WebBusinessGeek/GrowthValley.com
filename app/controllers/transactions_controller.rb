class TransactionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_resource, except: [:paid, :ipn,:revoked, :index]

  def index
    @transactions = current_user.transactions
  end

  def new
     @transaction = @resource.transactions.in_progress(current_user.id).last
     unless @transaction
       @transaction = Transaction.create!(resource: @resource, user_id: current_user.id)
     end
     @paypal = PaypalInterface::Request.new(@transaction)
     @paypal.express_checkout
     if @paypal.express_checkout_response.success?
       @paypal_url = @paypal.api.express_checkout_url(@paypal.express_checkout_response)
     else
       redirect_to :back, "error"
     end
  end

  def paid
    if @transaction = Transaction.pay(params[:token], params[:PayerID])
      msg = "yay"
    else
      msg = "boo"
    end
    redirect_to transactions_path, notice: msg
  end

  def revoked
    if @transaction = Transaction.cancel_payment(params)
      msg = "Payment canceled"
    end
    redirect_to transactions_path, notice: msg
  end

  def ipn
  end

  private
    def get_resource
      klass,id = params[:resource_type], params[:resource_id]
      @resource = klass.singularize.classify.constantize.find(id)
    end
end
