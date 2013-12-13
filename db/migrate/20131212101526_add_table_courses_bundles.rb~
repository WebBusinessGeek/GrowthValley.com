class AddTableCoursesBundles < ActiveRecord::Migration
  def up
    create_table :bundles_courses ,:id=>false do |t|
       t.references :course
       t.references :bundle
    end 
  end

  def down
    drop_table :bundles_courses
  end
end
