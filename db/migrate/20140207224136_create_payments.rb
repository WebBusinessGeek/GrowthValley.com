class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :transaction_id
      t.decimal :amount
      t.string :status
      t.string :txn_id
      t.text :data

      t.timestamps
    end
    add_index :payments, :transaction_id
  end
end
