module Pl
  class Classroom < ActiveRecord::Base
    attr_accessible :title, :description, :privacy

    belongs_to :course
    has_many :users_classrooms, class_name: "Pl::UsersClassroom"
    has_many :users, through: :users_classrooms, class_name: "User", uniq: true

    validates :course_id, presence: true

    state_machine initial: :requested do
      event :approve do
        transition :requested => :active
      end
      event :decline do
        transition :requested => :not_accepted
      end
      event :archive do
        transition [:requested, :active] => :archived
      end
    end

    def teacher
      @teacher ||= users.where(type: "Teacher").first
    end

    def learner
      @learner ||= users.where(type: "Learner").first
    end

    def price_per_lesson
      course.classroom_properties['cost_per_lesson'].to_i
    end

    def max_number_lessons
      course.classroom_properties['max_number_lessons'].to_i
    end
  end
end
