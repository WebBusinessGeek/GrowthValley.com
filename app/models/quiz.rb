class Quiz < ActiveRecord::Base
  attr_accessible :question, :option1, :option2, :option3, :option4, :correct_answer, :section_id

  belongs_to :section
  validates_associated :section

  has_many :learners_quizzes, dependent: :destroy
  accepts_nested_attributes_for :learners_quizzes, :allow_destroy => true

  validates_presence_of :question, :option1, :option2, :option3, :option4, :correct_answer
  validates_format_of :question, with: /^[\w\s]+$/, message: 'only character, numbers and _ are allowed!'

  default_scope { order("id asc") }
end
