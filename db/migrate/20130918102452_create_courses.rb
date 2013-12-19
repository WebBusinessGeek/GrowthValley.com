class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title, unique: true
      t.string :course_cover_pic
      t.text :description
      t.string :content_type, default: 'both'
      t.integer :sections_count, default: 1
      t.boolean :is_published, default: false
      t.string :status
      t.boolean :is_paid, default: false
      t.integer :price, default: 0

      t.timestamps
    end
  end
end
