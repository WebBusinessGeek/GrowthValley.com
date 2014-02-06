class CreatePlClassroomRequests < ActiveRecord::Migration
  def change
    create_table :pl_classroom_requests do |t|
      t.integer :course_id
      t.integer :learner_id
      t.boolean :teacher_approved
      t.boolean :learner_approved
      t.decimal :amount

      t.timestamps
    end
    add_index :pl_classroom_requests, :course_id
    add_index :pl_classroom_requests, :learner_id
  end
end
