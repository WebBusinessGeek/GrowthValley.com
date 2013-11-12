class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :course
      t.references :user
      t.string :user_type
      t.integer :current_section
      t.boolean :complete, default: false

      t.timestamps
    end
  end
end
