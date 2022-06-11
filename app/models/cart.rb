class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :line_items

  def add_product(product_id, quantity)
    current_item = line_items.find_by(product_id: product_id)
    product = Product.find(product_id)
    if current_item
      current_item.quantity = current_item.quantity + quantity.to_i
    else
      current_item = line_items.build(product_id: product_id, quantity: quantity, price: product.price)
    end
    current_item
  end

  def total_price
    line_items.to_a.sum(&:sub_total)
  end
end
