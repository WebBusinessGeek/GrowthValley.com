class CourseStepsController < ApplicationController
  include Wicked::Wizard
  steps :subjects, :description, :type, :sections_count

  def show
    @course = Course.find_by_id(session[:course_id])
    case step
    when 'wicked_finish'
      redirect_to sections_course_path(@course)
    else
      render_wizard
    end
  end

  def update
    @course = Course.find_by_id(session[:course_id])
    @course.attributes = params[:course]
    render_wizard @course
  end
end
