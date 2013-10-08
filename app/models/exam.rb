class Exam < ActiveRecord::Base
  attr_accessible :course_id, :question

  belongs_to :course
end
