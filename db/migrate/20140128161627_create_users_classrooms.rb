class CreateUsersClassrooms < ActiveRecord::Migration
  def change
    create_table :pl_users_classrooms do |t|
      t.integer :user_id
      t.integer :classroom_id
      t.integer :position

      t.timestamps
    end

    add_index :pl_users_classrooms, [:user_id, :classroom_id]
  end
end
