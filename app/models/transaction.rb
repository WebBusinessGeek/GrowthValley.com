class Transaction < ActiveRecord::Base
  attr_accessible :payerID, :resource_id, :resource_type, :payment_token, :user_id, :resource

  belongs_to :resource, polymorphic: true
  belongs_to :user
  has_one :payment

  scope :in_progress, ->(user) {where("user_id = ? AND payment_token IS NULL", user)}

  delegate :amount, to: :resource
  alias_method :total, :amount

  def self.pay(token, payerID)
    begin
      transaction = self.find_by_payment_token(token)
      transaction.payerID = payerID
      transaction.save
      # PaypalWorker.perform_async(order.id)
      return transaction
    rescue
      false
    end
  end

  def self.cancel_payment(params)
    begin
      transaction = self.find_by_payment_token(params[:token])
      transaction.status = "Cancelled"
      transaction.save
      return transaction
    rescue
      false
    end
  end

  def set_payment_details(details)
    self.create_payment(data: details)
  end

  def save_payment_errors(errors)
    self.create_payment(data: errors)
  end

  def code
    "Test Description"
  end

  def set_payment_token(token)
    update_attribute(:payment_token, token)
  end
end
