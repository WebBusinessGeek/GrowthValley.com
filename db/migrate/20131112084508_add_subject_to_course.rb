class AddSubjectToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :subject_id, :integer
  end
end
