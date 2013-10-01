class CourseStepsController < ApplicationController
  include Wicked::Wizard
  steps :subjects, :description, :type, :sections_count, :sections

  def show
    @course = Course.find_by_id(session[:course_id])

    if @course.sections_count.present?
      @course.sections_count.times do
        @course.sections.build
      end
    end

    case step
    when 'wicked_finish'
      redirect_to courses_path, notice: 'Course updated successfully!'
    else
      render_wizard
    end
  end

  def update
    @course = Course.find_by_id(session[:course_id])
    @course.attributes = params[:course]
    if step == :sections
      @course.status = :active
    else
      @course.status = step
    end
    render_wizard @course
  end
end
