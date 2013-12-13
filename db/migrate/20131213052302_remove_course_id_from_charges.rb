class RemoveCourseIdFromCharges < ActiveRecord::Migration
  def up
    remove_column :charges, :course_id
  end

  def down
    add_column :charges, :course_id, :integer
  end
end
