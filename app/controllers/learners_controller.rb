class LearnersController < ApplicationController
  before_filter :authenticate_user!
  def index
    @courses = Course.all_published_courses_for_subjects(current_user.subjects).page(params[:page])
  end

  def show
    @course = Course.all_published_courses_for_subjects(current_user.subjects).find_by_slug(params[:id])
  end

  def subscribe_course
    @course = Course.all_published_courses_for_subjects(current_user.subjects).find_by_slug(params[:id])
    if @course.present? and ((current_user.subjects.include?(@course.subject) and current_user.subscription_type == 'free') or current_user.subscription_type == 'paid')
    current_user.courses << @course unless current_user.courses.include?(@course)
    @course.subscriptions.where(user_id: current_user.id).first.update_attributes(user_type: 'Learner', current_section: 1, progress: 'course started')
	  add_activity_stream('COURSE', @course, 'subscribe')

    redirect_to course_path(@course), notice: 'Course subscribed successfully!'
    else
		@course = Course.find_by_slug(params[:id])
		redirect_to course_path(@course), notice: 'Subscribe the subject first!'
    end
  end

  def unsubscribe_course
    @course = Course.all_published_courses_for_subjects(current_user.subjects).find_by_slug(params[:id])
    current_user.courses.delete(@course) if current_user.courses.include?(@course)

    redirect_to course_path(@course), notice: 'Course unsubscribed successfully!'
  end

  def rate_course
    if params[:course_id].present?
      course = Course.find_by_id(params[:course_id])

      if params[:rate]
        rating = course.ratings.where(ip_address: request.remote_ip).first_or_initialize
        rating.rate = params[:rate]

        if rating.save
          render json: { status: 'success', data: 'Rating submitted successfully!' }
        else
          render json: { status: 'error', data: 'Sorry! Rating could not be saved, please try again later...' }
        end
      else
        render json: { status: 'error', data: 'Error! We did not receive your rating...' }
      end
    else
      render json: { status: 'error', data: 'Course not found!' }
    end
  end
end
