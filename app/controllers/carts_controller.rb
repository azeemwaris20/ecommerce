class CartsController < ApplicationController
  def show
    @cart = Cart.find(session[:cart_id])
  end

  def create; end

  def destroy
    empty_cart
    redirect_to cart_path(current_cart)
  end
end
