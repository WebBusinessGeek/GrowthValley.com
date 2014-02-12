class Pl::ClassroomRequest < ActiveRecord::Base
  attr_accessible :amount, :course_id, :learner_id, :teacher_approved, :learner_approved, :comments_attributes, :escrow
  belongs_to :course
  belongs_to :learner, class_name: "Learner", foreign_key: 'learner_id'
  belongs_to :classrooom, class_name: "Pl::Classroom", foreign_key: 'classroom_id'
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :transactions, as: :resource

  accepts_nested_attributes_for :comments, reject_if: proc { |attributes| attributes['body'].blank? }

  default_scope includes(:course)
  scope :completed, where("classroom_id IS NOT NULL")
  scope :incompleted, where("classroom_id IS NULL")

  delegate :minimum_price, to: :course, prefix: true
  delegate :title, to: :course, prefix: true

  validate do |request|
    Pl::ClassroomRequestValidator.new(request).validate
  end

  # A bit redundant but better code readability
  def awaiting_payment?
    final_approval? && !payment_made?
  end

  def payment_made?
    return false unless transactions.any?
    if transactions.last.completed?
      return true
    else
      return false
    end
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
    elsif !learner_approved? && !teacher_approved?
      "Awaiting Approval by both parties"
    elsif transactions.any?
      "Payment processing"
    elsif payment_made?
      "Payment made and classroom created"
    else
      "Initiated"
    end
  end
end

class Pl::ClassroomRequestValidator
  def initialize(record)
    @record = record
  end

  def validate
    if @record.amount < @record.course_minimum_price.to_i
      @record.errors[:amount] << "Amount cannot be less than the teachers minimum asking price."
    end
  end
end
