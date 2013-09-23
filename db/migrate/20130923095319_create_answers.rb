class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :title
      t.boolean :is_correct, default: false
      t.references :question

      t.timestamps
    end
  end
end
