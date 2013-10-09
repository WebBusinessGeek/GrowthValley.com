class LearnersController < ApplicationController
  def index
    @courses = Course.all_published_courses_for_subjects(current_user.subjects)
  end

  def show
    @course = Course.all_published_courses_for_subjects(current_user.subjects).find_by_id(params[:id])
  end

  def subscribe_course
    @course = Course.all_published_courses_for_subjects(current_user.subjects).find_by_id(params[:id])
    current_user.courses << @course unless current_user.courses.include?(@course)

    redirect_to learner_path(@course)
  end
end
