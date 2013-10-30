class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.references :user
      t.references :course
      t.string :stripe_token
      t.integer :amount

      t.timestamps
    end
  end
end
