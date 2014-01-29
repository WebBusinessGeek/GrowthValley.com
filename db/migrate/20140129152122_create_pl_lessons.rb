class CreatePlLessons < ActiveRecord::Migration
  def change
    create_table :pl_lessons do |t|
      t.integer :classroom_id
      t.string :title
      t.string :description
      t.boolean :completed
      t.integer :position

      t.timestamps
    end

    add_index :pl_lessons, :position
    add_index :pl_lessons, :classroom_id
  end
end
