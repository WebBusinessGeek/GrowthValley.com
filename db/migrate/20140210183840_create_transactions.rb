class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :payerID
      t.string :payment_token
      t.integer :resource_id
      t.string :resource_type

      t.timestamps
    end

    add_index :transactions, [:resource_id, :resource_id]
  end
end
