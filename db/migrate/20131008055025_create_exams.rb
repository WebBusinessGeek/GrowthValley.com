class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.text :title
      t.references :course

      t.timestamps
    end
  end
end
