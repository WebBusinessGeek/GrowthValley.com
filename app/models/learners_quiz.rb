class LearnersQuiz < ActiveRecord::Base
  attr_accessible :user_id, :quiz_id, :section_id, :user_input, :correct_answer

  belongs_to :user
  belongs_to :quiz
  belongs_to :section

  validates_presence_of :user_id, :quiz_id, :section_id, :user_input
  validates_inclusion_of :correct_answer, in: [true, false]
end
