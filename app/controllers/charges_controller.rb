class ChargesController < ApplicationController
  def index
  end

  def new
  end

  def create
    # Amount in cents
    @amount = 700

    customer = Stripe::Customer.create(
      :email => current_user.email,
      :plan => "premium_teacher",
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Premium Membership - Teacher - GrowthValley.com',
      :currency    => 'usd'
    )

    current_user.update_attributes(subscription_type: 'paid')

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end
