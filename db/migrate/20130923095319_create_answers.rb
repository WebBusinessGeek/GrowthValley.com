class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :option_1
      t.string :option_2
      t.string :option_3
      t.string :option_4
      t.integer :correct_option
      t.references :question

      t.timestamps
    end
  end
end
