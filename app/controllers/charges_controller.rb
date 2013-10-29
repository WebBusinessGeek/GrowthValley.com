class ChargesController < ApplicationController
  def new
    @course = Course.find_by_id(params[:course_id]) if params[:course_id].present?
  end

  def create
    course = Course.find_by_id(params[:course_id]) if params[:course_id].present?
    amount = course.price.to_i * 100 if course.present?

    customer = Stripe::Customer.create(
      :email => current_user.email,
      :plan => "course_subscription",
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => amount,
      :description => 'Course Subscription',
      :currency    => 'usd'
    )

    current_user.courses << course unless current_user.courses.include?(course)
    redirect_to learner_path(course), notice: 'Course subscribed successfully!'

    rescue Stripe::CardError => e
      redirect_to new_charges_path, alert: e.message
  end
end
