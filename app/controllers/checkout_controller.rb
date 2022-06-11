class CheckoutController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def new
    redirect_to cart_path(current_cart), alert: flash[:error] unless items_are_available
  end

  def create
    complete_transaction
    redirect_to root_path, notice: 'Thanks for shopping!'
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_checkout_path, alert: flash[:error]
  end

  def coupon
    check_discount(params[:coupon])
    redirect_to new_checkout_path, alert: flash[:error]
  end

  private

  def deliver_payment
    customer = Stripe::Customer.create({
                                         email: params[:stripeEmail],
                                         source: params[:stripeToken]
                                       })

    Stripe::Charge.create({
                            customer: customer.id,
                            amount: @amount,
                            description: 'Rails Stripe customer',
                            currency: 'usd'
                          })
  end

  def complete_transaction
    ActiveRecord::Base.transaction do
      @amount = after_discount
      deliver_payment
      set_order
      update_quantity
      empty_cart
    end
  end
end
