module Pl
  class UsersClassroom < ActiveRecord::Base
    belongs_to :user, class_name: "User"
    belongs_to :classroom, class_name: "Pl::Classroom"
    acts_as_list scope: :user
  end
end
