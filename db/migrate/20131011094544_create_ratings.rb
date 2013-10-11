class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.string :ip_address
      t.integer :rate
      t.references :course

      t.timestamps
    end
  end
end
