class CreateCoursesUsersJoinTable < ActiveRecord::Migration
  def change
    create_table 'courses_users', :id => false do |t|
      t.references :user
      t.references :course
    end
  end
end
