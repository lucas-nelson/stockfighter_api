class CreateOrders < ActiveRecord::Migration[5.0] # :nodoc:
  def change
    create_table :orders do |t|
      t.string :account, null: false
      t.string :direction, null: false
      t.string :order_type, null: false
      t.integer :price, null: false
      t.integer :quantity, null: false
      t.string :symbol, null: false
      t.string :venue, null: false

      t.timestamps
    end
  end
end
