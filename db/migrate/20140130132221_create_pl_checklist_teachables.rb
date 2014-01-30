class CreatePlChecklistTeachables < ActiveRecord::Migration
  def change
    create_table :pl_checklist_teachables do |t|

      t.timestamps
    end
  end
end
