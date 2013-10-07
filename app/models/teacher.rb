class Teacher < User
  def allowed_to_publish?(course_id)
    course = Course.find_by_id(course_id)

    if self.subscription_type == 'free'
      if course.is_paid == false
        Course.free_user_published_courses(self).count < ENV['FREE_USER_MAX_FREE_COURSES_COUNT'].to_i
      else
        return false
      end
    else
      if course.is_paid == false
        Course.paid_user_free_published_courses(self).count < ENV['PAID_USER_MAX_FREE_COURSES_COUNT'].to_i
      else
        Course.paid_user_paid_published_courses(self).count < ENV['PAID_USER_MAX_PAID_COURSES_COUNT'].to_i
      end
    end
  end
end
