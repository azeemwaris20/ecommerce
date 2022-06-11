module CartsHelper
  def current_cart
    set_cart
    @cart
  end

  def set_cart
    @cart = Cart.find_by(id: session[:cart_id])
    return unless @cart.nil?

    @cart = Cart.create
    session[:cart_id] = @cart.id
  end

  def update_cart
    setup_user_cart
    remove_session_cart
    session[:cart_id] = @cart_id
  end

  def empty_cart
    current_cart.line_items.each do |line_item|
      if line_item.order_id.nil?
        line_item.destroy
      else
        line_item.cart_id = nil
        line_item.save
      end
    end
  end

  def check_discount(name)
    @coupon = Coupon.find_by(name: name)
    if @coupon
      if @coupon.valid_til >= Date.today
        session[:discount] = @coupon.discount
      else
        flash[:error] = 'Coupon has been expired!'
      end
    else
      flash[:error] = "Coupon doesn't exist!"
    end
  end

  def items_count
    set_cart
    @cart.line_items.size
  end

  def setup_user_cart
    @cart = Cart.find_by(user_id: current_user.id)
    @cart = Cart.create(user_id: current_user.id) if @cart.nil?
    @cart_id = @cart.id
  end

  def remove_session_cart
    @cart_tmp = Cart.find_by(id: session[:cart_id])
    return if @cart_tmp.nil?

    move_line_items
    empty_cart
    @cart_tmp.destroy
  end

  def move_line_items
    @cart_tmp.line_items.each do |line_item|
      unless line_item.product.user.id == current_user.id
        line_item = @cart.add_product(line_item.product_id, line_item.quantity)
        line_item.save
      end
    end
  end
end
