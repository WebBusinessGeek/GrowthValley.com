class ExamQuestion < ActiveRecord::Base
  attr_accessible :question, :exam_id

  belongs_to :exam
  validates_associated :exam

  validates :question, presence: true, uniqueness: true
end
