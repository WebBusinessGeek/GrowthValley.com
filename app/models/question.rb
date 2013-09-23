class Question < ActiveRecord::Base
  attr_accessible :title

  belongs_to :quiz
  has_many :answers, dependent: :destroy

  validates :title, uniqueness: true
  validates :answers, :length => { maximum: 4 }, allow_blank: true

  accepts_nested_attributes_for :answers, limit: 4
end
