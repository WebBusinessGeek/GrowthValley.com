class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :title
      t.references :quiz

      t.timestamps
    end
  end
end
