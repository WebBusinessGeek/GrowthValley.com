class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :resource_id
      t.string :resource_type
      t.decimal :amount
      t.string :status
      t.string :transation_id
      t.string :type
      t.text :params

      t.timestamps
    end
    add_index :payments, [:id, :type]
    add_index :payments, [:resource_id, :resource_type]
  end
end
