class CreateCarts < ActiveRecord::Migration[5.0]
  def change
    create_table :carts do |t|
      t.integer :user_id,    null: false
      t.integer :product_id, null: false
      t.integer :quantity,   null: false, default: 1

      t.timestamps           null: false
    end
  end
end
