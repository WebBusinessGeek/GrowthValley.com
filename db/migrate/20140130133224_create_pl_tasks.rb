class CreatePlTasks < ActiveRecord::Migration
  def change
    create_table :pl_tasks do |t|
      t.boolean :completed
      t.string :content
      t.integer :checklist_id

      t.timestamps
    end
    add_index :pl_tasks, :checklist_id
  end
end
