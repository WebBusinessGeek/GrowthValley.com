class LearnersExamsController < ApplicationController
  def new
    if params[:course_id].present?
      @course = current_user.courses.find_by_slug(params[:course_id])

      if @course.present?
        answered_exam_questions = @course.learners_exams.where(user_id: current_user.id, exam_id: @course.exam.id).collect(&:exam_question_id)

        if answered_exam_questions.present?
          @exam_question = @course.exam.exam_questions.where('id not in (?)', answered_exam_questions).order('id asc').first
        else
          @exam_question = @course.exam.exam_questions.order('id asc').first
        end

        if @exam_question.present?
          @exam_answer = current_user.learners_exams.build(user_id: current_user.id, course_id: @course.id, exam_id: @course.exam.id, exam_question_id: @exam_question.id)
        else
          redirect_to course_path(@course), alert: 'You cannot take an exam again!'
        end
      end
    end
  end

  def create
    if params[:learners_exam].present?
      exam_answer = current_user.learners_exams.build(params[:learners_exam])
      course = Course.find(params[:learners_exam][:course_id])

      if exam_answer.save
        redirect_to new_learners_exam_path(course_id: course)
      else
        render :new
      end
    end
  end
end
