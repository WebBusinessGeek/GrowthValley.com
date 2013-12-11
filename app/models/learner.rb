class Learner < User
  has_and_belongs_to_many :teachers

  def teacher_subscribed?(course_id)
    course = Course.find_by_slug(course_id)
    teacher = course.users.where(:type  => 'Teacher').first

    teachers.include?(teacher)
  end

  def subscribe_teacher(course_id)
    course = Course.find_by_slug(course_id)
    teacher = course.users.where(:type  => 'Teacher').first

    unless teacher_subscribed?(course.slug)
      teachers.push(teacher)
    end
  end
end
