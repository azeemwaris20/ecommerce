module OrdersHelper
  def set_order
    @order = Order.create(user_id: current_user.id)
    current_cart.line_items.each do |line_item|
      line_item.order_id = @order.id
      line_item.save
    end
  end

  def after_discount
    if session[:discount]
      (current_cart.total_price.to_i - total_discount).to_s
    else
      current_cart.total_price
    end
  end

  def items_are_available
    current_cart.line_items.each do |line_item|
      if line_item.quantity > line_item.product.quantity
        flash[:error] = line_item.product.name + ' has available quantity ' + line_item.product.quantity.to_s
        return false
      end
    end
    true
  end

  def update_quantity
    current_cart.line_items.each do |line_item|
      @product = Product.find(line_item.product.id)
      @product.quantity = @product.quantity - line_item.quantity
      @product.save
    end
  end

  def total_discount
    ((current_cart.total_price.to_i / 100) * session[:discount].to_i)
  end
end
