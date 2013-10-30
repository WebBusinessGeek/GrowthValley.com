class Charge < ActiveRecord::Base
  attr_accessible :user_id, :course_id, :stripe_token, :amount

  belongs_to :user
  belongs_to :course

  validates_presence_of :user_id, :stripe_token, :amount
end
