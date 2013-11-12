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
          redirect_to my_courses_courses_path, alert: 'You cannot take an exam again!'
        end
      end
    end
  end

  def create
    if params[:learners_exam][:exam_id].present?
      if params[:learners_exam][:course_id].present?
        @course = current_user.courses.find_by_slug(params[:learners_exam][:course_id])

        if @course.present?
          answered_exam_questions = @course.learners_exams.where(user_id: current_user.id, exam_id: @course.exam.id).collect(&:exam_question_id)

          if answered_exam_questions.present?
            @exam_question = @course.exam.exam_questions.where('id not in (?)', answered_exam_questions).order('id asc').first
          else
            @exam_question = @course.exam.exam_questions.order('id asc').first
          end

          if @exam_question.present?
            @exam_answer = current_user.learners_exams.build(user_id: current_user.id, course_id: @course.id, exam_id: @course.exam.id, exam_question_id: @exam_question.id)

            if @exam_answer.save
              current_user.subscriptions.where(course_id: @course.id, user_type: 'Learner').update_attribute(:complete, true)
            end
          end
        end
      end
    else
      render :new
    end
  end
end
