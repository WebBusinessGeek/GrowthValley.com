class ChargesController < ApplicationController
  before_filter :authenticate_user!
  def new
  end

  def create
    if params[:subscription_type].present?
      if params[:subscription_type].downcase == "premium_teacher"
        ## Premium Teacher Membership code begins...
#          begin
#            customer = Stripe::Customer.create(
#              :email => current_user.email,
#              :card  => params[:stripeToken],
#              :description => "Monthly Membership charges for Premium Teacher"
#            )

#            customer.update_subscription(
#              :plan => "premium_teacher_membership"
#            )
#          rescue Stripe::CardError => e
#            redirect_to new_charges_path, alert: e.message
#          else
#            charge = Charge.new(user_id: current_user.id, stripe_token: params[:stripeToken], amount: 7)

#            if !charge.save
#              render :edit
#            else
#              current_user.update_attributes(subscription_type: 'paid')
#              redirect_to charges_path, notice: 'Successfully upgraded to premium teacher membership!'
#            end
#          end
        ## Premium Teacher Membership code ends...

      elsif params[:subscription_type].downcase == "premium_learner"
        ## Premium Learner Membership code begins...
#          begin
#            customer = Stripe::Customer.create(
#              :email => current_user.email,
#              :card  => params[:stripeToken],
#              :description => "Monthly Membership charges for Premium Learner"
#            )

#            customer.update_subscription(
#              :plan => "premium_learner_membership"
#            )
#          rescue Stripe::CardError => e
#            redirect_to new_charges_path, alert: e.message
#          else
#            charge = Charge.new(user_id: current_user.id, stripe_token: params[:stripeToken], amount: 7)

#            if !charge.save
#              render :edit
#            else
#              current_user.update_attributes(subscription_type: 'paid')
#              redirect_to charges_path, notice: 'Successfully upgraded to premium learner membership!'
#            end
#          end
        ## Premium Learner Membership code ends...

      elsif params[:subscription_type].downcase == "course_subscription"
        ## Course subscription code begins...
          course = Course.find_by_id(params[:course_id]) if params[:course_id].present?
          amount = course.price.to_i * 100 if course.present? # amount in cents
          course_name = course.title if course.present?

#          begin
#            customer = Stripe::Customer.create(
#              :email => current_user.email,
#              :card  => params[:stripeToken]
#            )

#            charge = Stripe::Charge.create(
#              :customer    => customer.id,
#              :amount      => amount,
#              :description => "Subscription to " + course_name,
#              :currency    => 'usd'
#            )
#          rescue Stripe::CardError => e
#            redirect_to new_charges_path, alert: e.message
#          else
#            charge = Charge.new(user_id: current_user.id, course_id: course.id, stripe_token: params[:stripeToken], amount: amount/100)

#            if !charge.save
#              render :edit
#            else
#              current_user.courses << course unless current_user.courses.include?(course)
#			        course.subscriptions.where(user_id: current_user.id).first.update_attributes(user_type: 'Learner', current_section: 1, progress: 'course started')
#			        add_activity_stream('COURSE', course, 'subscribe')

#              redirect_to course_path(course), notice: 'Course subscribed successfully!'
#            end
#          end
        ## Course subscription code ends...
      end
    else
      redirect_to charges_path, alert: "Invalid subscription type"
    end
  end

  def success
    charge = Charge.new(user_id: current_user.id, amount: 7)

    if charge.save
      current_user.update_attributes(subscription_type: 'paid')

      if current_user.type == 'Teacher'
        redirect_to charges_path, notice: 'Successfully upgraded to premium teacher membership!'
      else
        redirect_to charges_path, notice: 'Successfully upgraded to premium learner membership!'
      end
    else
      render :new
    end
  end
end
