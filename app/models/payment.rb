class Payment < ActiveRecord::Base
  attr_accessible :amount, :params, :resource_id, :resource_type, :status, :transation_id, :type

  # All resource models should have a token and payerID string
  belongs_to :resource, polymorphic: true

  serialize :params

  scope :successful, where(status: 'Completed')

  def paypal_values(return_url, cancel_url, notify_url)
    # Implement in subclass
    raise NotImplementedError, "Override paypal_values in subclass"
  end
end
