class AddClassroomPropertiesToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :classroom_properties, :hstore
    add_column :courses, :classroom_enabled, :boolean, default: false
  end
end
