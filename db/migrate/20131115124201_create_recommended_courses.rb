class CreateRecommendedCourses < ActiveRecord::Migration
  def change
    create_table :recommended_courses do |t|
      t.references :user
      t.references :exam
      t.references :course

      t.timestamps
    end
  end
end
