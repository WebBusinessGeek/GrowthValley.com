class Subscription < ActiveRecord::Base
  attr_accessible :course_id, :user_id, :user_type, :current_section, :complete

  belongs_to :course
  belongs_to :user
end
