class Quiz < ActiveRecord::Base
  attr_accessible :title, :section_id, :questions_attributes

  belongs_to :section
  has_many :questions, dependent: :destroy
  has_many :answers, through: :questions

  validates :title, uniqueness: true
  validates :questions, :length => { maximum: 10 }, allow_blank: true

  accepts_nested_attributes_for :questions, limit: 10
  accepts_nested_attributes_for :answers

  def complete?
    if self.questions.present? && self.answers.present?
      return true
    else
      return false
    end
  end
end
