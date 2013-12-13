class PremiumCourse < ActiveRecord::Base
  attr_accessible :user_id, :amount, :course_id

  belongs_to :user
  belongs_to :course

  validates_presence_of :user_id, :amount, :course_id
end
