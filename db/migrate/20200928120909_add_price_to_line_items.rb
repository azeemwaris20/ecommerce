class AddPriceToLineItems < ActiveRecord::Migration[5.2]
  def change
    add_column :line_items, :price, :integer, precision: 5, scale: 2
  end
end
