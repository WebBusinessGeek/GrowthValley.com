class ExamQuestion < ActiveRecord::Base
  attr_accessible :question, :exam_id

  belongs_to :exam
  validates_associated :exam

  has_many :learners_exams, dependent: :destroy
  accepts_nested_attributes_for :learners_exams, :allow_destroy => true

  validates :question, presence: true, uniqueness: true
end
