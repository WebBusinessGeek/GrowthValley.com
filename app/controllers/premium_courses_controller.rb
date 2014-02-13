class PremiumCoursesController < ApplicationController
  before_filter :authenticate_user!
  def new
    if params[:course_id].present?
      @course = Course.find_by_id(params[:course_id])

      if(current_user.subjects.include?(@course.subject) and current_user.subscription_type == 'free') or current_user.subscription_type == 'paid'
        t = 1
        session[:course_id] = @course.id
        subscribe_to_course
      else
        redirect_to course_path(@course), notice: 'Subscribe the subject first!'
      end
    elsif params[:bundle_id].present?
      @bundle = Bundle.find_by_id(params[:bundle_id])
      session[:bundle_id] = params[:bundle_id]
      subscribe_to_course
    else
      redirect_to :back, :alert => 'Course not found!'
    end
  end

  def success
    subscribe_to_course
  end

  private
    def subscribe_to_course
      if session[:course_id].present?
        course = Course.find_by_id(session[:course_id])
        current_user.courses << course unless current_user.courses.include?(course)
        course.subscriptions.where(user_id: current_user.id).first.update_attributes(user_type: 'Learner', current_section: 1, progress: 'course started')
        add_activity_stream('COURSE', course, 'subscribe')
        session[:course_id] = nil

        redirect_to course_path(course), notice: 'Course subscribed successfully!'
      elsif session[:bundle_id].present?
        bundle = Bundle.find_by_id(session[:bundle_id])

        unless current_user.bundles.include?(bundle)
          current_user.bundles.push(bundle)
        end

        session[:bundle_id] = nil
        redirect_to bundle_path(bundle), notice: 'Bundle subscribed successfully!'
      else
        redirect_to :back, :alert => "Invalid Parameters!"
      end
    end
end
