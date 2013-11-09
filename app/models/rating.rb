class Rating < ActiveRecord::Base
  attr_accessible :ip_address, :rating, :course_id

  belongs_to :course
end
