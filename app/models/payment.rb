class Payment < ActiveRecord::Base
  attr_accessible :amount, :data, :status, :txn_id

  belongs_to :transaction

  serialize :data

  scope :successful, where(status: 'Completed')
end
