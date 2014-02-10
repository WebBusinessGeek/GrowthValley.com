class Payment < ActiveRecord::Base
  attr_accessible :amount, :data, :status, :txn_id

  belongs_to :transation

  serialize :data

  scope :successful, where(status: 'Completed')
end
