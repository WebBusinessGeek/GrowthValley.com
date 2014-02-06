class Pl::ClassroomRequest < ActiveRecord::Base
  attr_accessible :amount, :course_id, :learner_id, :teacher_approved, :learner_approved, :comments_attributes
  belongs_to :course
  belongs_to :learner, class_name: "Learner", foreign_key: 'learner_id'
  has_many :comments, as: :commentable, dependent: :destroy

  accepts_nested_attributes_for :comments, reject_if: proc { |attributes| attributes['body'].blank? }

  # A bit redundant but better code readability
  def awaiting_payment?
    final_approval?
  end

  def final_approval?
    learner_approved? && teacher_approved?
  end

  def quick_approvable?(type)
    send("#{['learner','teacher'].detect {|i| i != type.downcase}}_approved?".to_sym)
  end

  def status
    if awaiting_payment?
      "Awaiting Payment"
    elsif learner_approved? && !teacher_approved?
      "Awaiting Teacher Approval"
    elsif teacher_approved? && !learner_approved?
      "Awaiting Learner Approval"
    else
      "Awaiting Approval by both parties"
    end
  end
end