class CreateExamQuestions < ActiveRecord::Migration
  def change
    create_table :exam_questions do |t|
      t.text :question
      t.references :exam

      t.timestamps
    end
  end
end
