class Answer < ActiveRecord::Base
  attr_accessible :option_1, :option_2, :option_3, :option_4, :correct_option, :question_id

  belongs_to :question

  validates_presence_of :option_1, :option_2, :option_3, :option_4, :correct_option
  validates :correct_option, inclusion: { in: 1..4 }
end
