class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string  :name,      null: false, default: ""
      t.integer :parent_id, null: false, default: 0

      t.timestamps          null: false
    end
  end
end
