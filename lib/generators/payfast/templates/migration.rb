class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.float :amount
      t.string :item_name
      t.string :email_address
      t.string :payment_uuid
      t.boolean :is_paid
      t.timestamps
    end
  end
end
