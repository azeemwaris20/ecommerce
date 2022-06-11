class AddNullFalseToCoupons < ActiveRecord::Migration[5.2]
  def change
    change_column :coupons, :name, :string, null: false
  end
end
