class CreatePlContents < ActiveRecord::Migration
  def change
    create_table :pl_contents do |t|
      t.integer :teachable_id
      t.string :teachable_type
      t.string :title
      t.integer :lesson_id

      t.timestamps
    end
    add_index :pl_contents, :lesson_id
    add_index :pl_contents, [:teachable_id, :teachable_type]
  end
end
