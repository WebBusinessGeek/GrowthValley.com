class CreateLearnersQuizzes < ActiveRecord::Migration
  def change
    create_table :learners_quizzes do |t|
      t.references :user
      t.references :quiz
      t.references :section
      t.integer :user_input
      t.boolean :correct_answer

      t.timestamps
    end
  end
end
