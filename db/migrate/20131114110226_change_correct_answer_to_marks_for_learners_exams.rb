class ChangeCorrectAnswerToMarksForLearnersExams < ActiveRecord::Migration
  def up
    remove_column :learners_exams, :correct_answer
    add_column :learners_exams, :score, :integer
  end

  def down
    remove_column :learners_exams, :score
    add_column :learners_exams, :correct_answer, :boolean
  end
end
