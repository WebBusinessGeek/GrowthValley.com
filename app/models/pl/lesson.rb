class Pl::Lesson < ActiveRecord::Base
  attr_accessible :completed, :description, :position, :title
end
