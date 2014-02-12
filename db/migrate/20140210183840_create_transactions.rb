class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.string :payerID
      t.string :payment_token
      t.integer :resource_id
      t.string :resource_type
      t.boolean :transfer
      t.string :status

      t.timestamps
    end

    add_index :transactions, [:resource_id, :resource_id]
    add_index :transactions, :user_id
    add_index :transactions, :status
  end
end
