class Pl::Lesson < ActiveRecord::Base
  attr_accessible :completed, :description, :position, :title

  belongs_to :classroom
  has_many :contents, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  acts_as_list scope: :classroom

  scope :completed, where(completed: true)
end
