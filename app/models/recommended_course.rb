class RecommendedCourse < ActiveRecord::Base
  attr_accessible :user_id, :exam_id, :course_id

  belongs_to :user
  belongs_to :exam
  belongs_to :course
end
