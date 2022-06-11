class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.string :name
      t.decimal :discount, precision: 5, scale: 2
      t.date :valid_til

      t.timestamps
    end
  end
end
