class Exam < ActiveRecord::Base
  attr_accessible :title, :course_id, :exam_questions_attributes

  belongs_to :course
  validates_associated :course

  has_many :exam_questions, dependent: :destroy
  validates :exam_questions, :length => { minimum: 3 }, allow_blank: true
  accepts_nested_attributes_for :exam_questions, :allow_destroy => true

  validates :title, presence: true
end
