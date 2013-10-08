class ExamQuestion < ActiveRecord::Base
  attr_accessible :question, :exam_id

  belongs_to :exam
  validates_associated :exam
end
