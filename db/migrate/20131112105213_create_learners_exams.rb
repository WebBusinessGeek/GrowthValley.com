class CreateLearnersExams < ActiveRecord::Migration
  def change
    create_table :learners_exams do |t|
      t.references :user
      t.references :exam
      t.references :exam_question
      t.references :course
      t.text :user_input
      t.boolean :correct_answer

      t.timestamps
    end
  end
end
