class CourseStepsController < ApplicationController
  include Wicked::Wizard
  prepend_before_filter :set_steps

  def show
    @course = current_user.courses.find_by_id(session[:course_id])

    if @course.sections_count.present?
      @course.sections_count.times do
        @course.sections.build
      end
    end

    case step
    when 'wicked_finish'
      redirect_to my_courses_courses_path, notice: 'Course updated successfully!'
    else
      render_wizard
    end
  end

  def update
    @course = current_user.courses.find_by_id(session[:course_id])
    @course.attributes = params[:course]
    if step == :sections
      @course.status = :active
    else
      @course.status = step
    end
    render_wizard @course
  end

  private
  def set_steps
    @course = current_user.courses.find_by_id(session[:course_id])

    if @course.is_paid
      self.steps = [:price, :subjects, :description, :type, :sections_count, :sections]
    else
      self.steps = [:subjects, :description, :type, :sections_count, :sections]
    end
  end
end
