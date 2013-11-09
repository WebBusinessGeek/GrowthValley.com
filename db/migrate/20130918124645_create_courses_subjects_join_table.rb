class CreateCoursesSubjectsJoinTable < ActiveRecord::Migration
  def change
    create_table 'courses_subjects', :id => false do |t|
      t.references :course
      t.references :subject
    end
  end
end
