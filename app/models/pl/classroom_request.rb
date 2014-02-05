class Pl::ClassroomRequest < ActiveRecord::Base
  attr_accessible :amount, :course_id, :learner_id, :teacher_approved, :learner_approved, :comments_attributes
  belongs_to :course
  belongs_to :learner, class_name: "Learner", foreign_key: 'learner_id'
  has_many :comments, as: :commentable, dependent: :destroy

  accepts_nested_attributes_for :comments, reject_if: proc { |attributes| attributes['body'].blank? }
end