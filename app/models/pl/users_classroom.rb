module Pl
  class UsersClassroom < ActiveRecord::Base
    belongs_to :user, class_name: "User"
    belongs_to :classroom, class_name: "Pl::Classroom"
  end
end
