class LearnersExam < ActiveRecord::Base
  attr_accessible :user_id, :exam_id, :exam_question_id, :course_id, :user_input, :correct_answer

  belongs_to :user
  belongs_to :exam
  belongs_to :exam_question
  belongs_to :course

  scope :for_courses, ->(course_ids) { where(course_id: course_ids) }
end
