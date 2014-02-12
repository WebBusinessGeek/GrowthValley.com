class Transaction < ActiveRecord::Base
  attr_accessible :payerID, :resource_id, :resource_type, :payment_token, :user_id, :resource

  belongs_to :resource, polymorphic: true
  belongs_to :user
  has_one :payment, dependent: :destroy

  scope :in_progress, ->(user) {where("user_id = ? AND payment_token IS NOT NULL AND status IS NULL", user)}

  delegate :amount, to: :resource
  alias_method :total, :amount

  def self.pay(token, payerID)
    begin
      transaction = self.find_by_payment_token(token)
      transaction.payerID = payerID
      transaction.status = "In Progress"
      transaction.save
      PaypalWorker.perform_async(transaction.id)
      return transaction
    rescue
      false
    end
  end

  def self.cancel_payment(params)
    begin
      transaction = self.find_by_payment_token(params[:token])
      transaction.status = "Cancelled"
      transaction.save
      return transaction
    rescue
      false
    end
  end

  def set_payment_details(details)
    @payment = self.build_payment(data: details.inspect.to_s)
    @payment.txn_id = details.PaymentInfo[0].TransactionID
    @payment.status = details.PaymentInfo[0].PaymentStatus
    @payment.amount = details.PaymentInfo[0].GrossAmount.value
    @payment.save
    self.status = "Completed"
    self.save
    case self.resource_type
    when 'Pl::ClassroomRequest'
      @classroom = Pl::Classroom.add_classroom({
        "course_id" => self.resource.course_id,
        "learner_id" => self.resource.learner_id,
        "active" => true
      })
      if @classroom
        self.resource.update_attribute(:classroom_id, @classroom)
      end
    else
    end
  end

  def save_payment_errors(errors)
    @payment = self.build_payment(data: errors.to_s)
    @payment.status = "Error"
    @payment.save
    self.status = "Error"
    self.save
  end

  def code
    case resource_type
    when 'Pl::ClassroomRequest'
      "Classroom purchased for #{resource.course.title}"
    else
      "$#{amount} purchase"
    end
  end

  def set_payment_token(token)
    self.payment_token = token
    self.save
  end

  def completed?
    status == 'Completed'
  end
end
