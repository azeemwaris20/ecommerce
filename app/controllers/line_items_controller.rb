class LineItemsController < ApplicationController
  before_action :set_cart, only: [:create]
  before_action :fetch_product, only: [:create]

  def create
    if params[:quantity].to_i <= @product.quantity
      @line_item = @cart.add_product(@product.id, params[:quantity])
      redirect_to cart_path(current_cart) if @line_item.save
    else
      redirect_to product_path(@product), alert: 'Available quantity is: ' + @product.quantity.to_s
    end
  end

  def destroy
    @cart = Cart.find(session[:cart_id])
    current_item = @cart.line_items.find(params[:id])
    current_item&.destroy
    redirect_to cart_path(@cart)
  end

  private

  def line_item_params
    params.require(:line_item).permit(:product_id, :price)
  end

  def fetch_product
    @product = Product.find(params[:product_id])
  end
end
