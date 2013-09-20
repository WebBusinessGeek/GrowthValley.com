class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title, unique: true
      t.text :description
      t.string :content_type
      t.integer :sections_count, default: 0
      t.boolean :is_published, null: false, default: false

      t.timestamps
    end
  end
end
