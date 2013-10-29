class LearnersController < ApplicationController
  layout 'home'

  def index
    @courses = Course.all_published_courses_for_subjects(current_user.subjects)
  end

  def show
    @course = Course.all_published_courses_for_subjects(current_user.subjects).find_by_id(params[:id])
  end

  def subscribe_course
    @course = Course.all_published_courses_for_subjects(current_user.subjects).find_by_id(params[:id])
    current_user.courses << @course unless current_user.courses.include?(@course)

    redirect_to learner_path(@course), notice: 'Course subscribed successfully!'
  end

  def unsubscribe_course
    @course = Course.all_published_courses_for_subjects(current_user.subjects).find_by_id(params[:id])
    current_user.courses.delete(@course) if current_user.courses.include?(@course)

    redirect_to learner_path(@course), notice: 'Course unsubscribed successfully!'
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
