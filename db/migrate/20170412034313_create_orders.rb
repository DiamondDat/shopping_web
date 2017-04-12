class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :user_id, null: false
      t.string  :status,  null: false, default: "pending"
      t.integer :approved_by_admin_id

      t.timestamps null: false
    end
  end
end
