class PaypalTransferWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(classroom_id)
    @classroom = Pl::Classroom.find(classroom_id)
    @transaction = @classroom.transactions.create(
      resource: @classroom,
      user_id: @classroom.teacher.id,
      transfer: true
    )
    @paypal = PaypalInterface::Transfer.new(@transaction)
    @response = @paypal.masspay
    puts @response.inspect
  end
end