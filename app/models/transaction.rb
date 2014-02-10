class Transaction < ActiveRecord::Base
  attr_accessible :payerID, :resource_id, :resource_type, :payment_token

  belongs_to :resource, polymorphic: true
  has_one :payment

  delegate :amount, to: :resource
end
