class CreatePlClassrooms < ActiveRecord::Migration
  def change
    create_table :pl_classrooms do |t|
      t.string :title
      t.string :description
      t.boolean :privacy
      t.string :guid
      t.integer :course_id
      t.timestamps
    end
  end
end
