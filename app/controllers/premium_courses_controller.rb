class PremiumCoursesController < ApplicationController
  def new
    if params[:course_id].present?
      @course = Course.find_by_id(params[:course_id])
      
      if(current_user.subjects.include?(@course.subject) and current_user.subscription_type == 'free') or current_user.subscription_type == 'paid'
        t = 1
        session[:course_id] = @course.id
      else
        redirect_to course_path(@course), notice: 'Subscribe the subject first!'
      end
    else
      redirect_to :back, :alert => 'Course not found!'
    end
  end

  def success
    course = Course.find_by_id(session[:course_id])
    premium_course = PremiumCourse.new(:user_id => current_user.id, :amount => course.price.to_i, :course_id => course.id)

    if premium_course.save
      current_user.courses << course unless current_user.courses.include?(course)
      course.subscriptions.where(user_id: current_user.id).first.update_attributes(user_type: 'Learner', current_section: 1, progress: 'course started')
      add_activity_stream('COURSE', course, 'subscribe')
      session[:course_id] = nil

      redirect_to course_path(course), notice: 'Course subscribed successfully!'
    else
      render :new
    end
  end
end
