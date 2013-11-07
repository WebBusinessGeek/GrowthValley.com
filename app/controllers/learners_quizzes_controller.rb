class LearnersQuizzesController < ApplicationController
  def new
    if params[:section_id].present?
      section = Section.find_by_id(params[:section_id])
      if section.present? && current_user.present?
        answered_quizzes = section.learners_quizzes.where(user_id: current_user.id).collect(&:quiz_id)
      end
    end

    if answered_quizzes.present?
      @quiz_question = section.quizzes.where('id not in (?)', answered_quizzes).first
    else
      @quiz_question = section.quizzes.first
    end

    @quiz_answer = current_user.learners_quizzes.build(quiz_id: @quiz_question.id, section_id: section.id)
  end

  def create
    if params[:learners_quiz][:section_id].present?
      section = Section.find_by_id(params[:learners_quiz][:section_id])
      if section.present? && current_user.present?
        answered_quizzes = section.learners_quizzes.where(user_id: current_user.id).collect(&:quiz_id)
      end
    end

    if answered_quizzes.present?
      @quiz_question = section.quizzes.where('id not in (?)', answered_quizzes).first
    else
      @quiz_question = section.quizzes.first
    end

    if @quiz_question.correct_answer == params[:learners_quiz][:user_input].to_i
      @quiz_answer = current_user.learners_quizzes.build(quiz_id: params[:learners_quiz][:quiz_id], section_id: params[:learners_quiz][:section_id], user_input: params[:learners_quiz][:user_input], correct_answer: true)
    else
      @quiz_answer = current_user.learners_quizzes.build(quiz_id: params[:learners_quiz][:quiz_id], section_id: params[:learners_quiz][:section_id], user_input: params[:learners_quiz][:user_input], correct_answer: false)
    end

    if @quiz_answer.save
      if section.quizzes.where('id not in (?)', answered_quizzes).length == 1
        course = Course.find_by_id(section.course_id).sections.where(unlocked: false)
        if course.present?
          course.first.update_attribute(:unlocked, true)
          redirect_to learner_path(section.course.id), notice: 'Next section unlocked!'
          return
        else
          redirect_to learner_path(section.course.id)
          return
        end
      else
        redirect_to new_learners_quiz_path(section_id: params[:learners_quiz][:section_id]), notice: 'Answer submitted successfully!'
      end
    else
      render :new
    end
  end
end
