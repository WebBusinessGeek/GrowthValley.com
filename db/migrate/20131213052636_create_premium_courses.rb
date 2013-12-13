class CreatePremiumCourses < ActiveRecord::Migration
  def change
    create_table :premium_courses do |t|
      t.references :user
      t.integer :amount
      t.references :course

      t.timestamps
    end
  end
end
