class QuizStepsController < ApplicationController
  include Wicked::Wizard
  steps :question, :answers

  def show
    @quiz = Quiz.find_by_id(session[:quiz_id])
    @quiz.questions.build
    @quiz.answers.build

    case step
    when 'wicked_finish'
      redirect_to course_path(@quiz.section.course), notice: 'Quiz created successfully!'
    else
      render_wizard
    end
  end

  def update
    @quiz = Quiz.find_by_id(session[:quiz_id])
    @quiz.attributes = params[:quiz]
    render_wizard @quiz
  end
end
