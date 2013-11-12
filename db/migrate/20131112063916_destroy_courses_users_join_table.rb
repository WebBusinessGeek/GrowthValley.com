class DestroyCoursesUsersJoinTable < ActiveRecord::Migration
  def up
    drop_table :courses_users
  end

  def down
    create_table 'courses_users', :id => false do |t|
      t.references :user
      t.references :course
    end
  end
end
