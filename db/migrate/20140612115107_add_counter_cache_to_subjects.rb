class AddCounterCacheToSubjects < ActiveRecord::Migration
  class Subject < ActiveRecord::Base
    has_many :courses
  end
  def up
  	add_column :subjects, :courses_count, :integer, default: 0
  	Subject.reset_column_information
  	Subject.all.each do |s|
  		Subject.update_counters s.id, courses_count: s.courses.length
  	end
  end
  def down
  	remove_column :subjects, :courses_count
  end
end
