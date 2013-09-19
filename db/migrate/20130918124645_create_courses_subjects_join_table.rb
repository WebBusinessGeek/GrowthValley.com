class CreateCoursesSubjectsJoinTable < ActiveRecord::Migration
  def change
    create_table 'courses_subjects', :id => false do |t|
      t.references :course, :null => false
      t.references :subject, :null => false
    end
  end
end
