class Charge < ActiveRecord::Base
  attr_accessible :user_id, :amount#, :stripe_token

  belongs_to :user

  validates_presence_of :user_id, :amount#, :stripe_token
end
