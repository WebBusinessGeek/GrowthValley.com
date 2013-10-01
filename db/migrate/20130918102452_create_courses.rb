class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title, unique: true
      t.text :description
      t.string :content_type
      t.integer :sections_count, default: 1
      t.boolean :is_published, null: false, default: false
      t.string :status

      t.timestamps
    end
  end
end
