class Question < ActiveRecord::Base
  attr_accessible :title, :answers_attributes, :section_id

  belongs_to :section
  has_many :answers, dependent: :destroy

  validates :title, presence: true, uniqueness: true

  accepts_nested_attributes_for :answers, :allow_destroy => true, limit: 4
end
