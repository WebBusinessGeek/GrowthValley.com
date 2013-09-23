class Answer < ActiveRecord::Base
  attr_accessible :title, :is_correct

  belongs_to :question

  validates :title, uniqueness: true
end
