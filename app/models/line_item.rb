class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart, optional: true
  belongs_to :order, optional: true

  def sub_total
    product.price.to_i * quantity.to_i
  end
end
