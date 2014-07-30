class LearnersExamsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :allowed_to_access?

  def new
    if params[:course_id].present?
      @course = current_user.courses.find_by_slug(params[:course_id])

      if @course.present?
        answered_exam_questions = @course.learners_exams.where(user_id: current_user.id, exam_id: @course.exam.id).collect(&:exam_question_id)

        if answered_exam_questions.present?
          @question_count = answered_exam_questions.count + 1
          @exam_question = @course.exam.exam_questions.where('id not in (?)', answered_exam_questions).order('id asc').first
        else
          @question_count = 1
          @exam_question = @course.exam.exam_questions.order('id asc').first
        end

        if @exam_question.present?
          @exam_answer = current_user.learners_exams.build(user_id: current_user.id, course_id: @course.id, exam_id: @course.exam.id, exam_question_id: @exam_question.id)
         render layout:'home_new'
        else
          redirect_to course_path(@course), notice: 'Exam completed successfully!' ,layout:'home_new'
        end
      end
    end       
    end

  def create
    if params[:learners_exam].present?
      exam_answer = current_user.learners_exams.build(params[:learners_exam])
      course = Course.find(params[:learners_exam][:course_id])

      if exam_answer.save
        Subscription.where(user_id: current_user.id, course_id: course.id).first.update_attributes(progress: "exam given")
        add_activity_stream('COURSE', course, 'completed') 
        redirect_to new_learners_exam_path(course_id: course)
      else
        render :new
      end
    end
  end

  private

    def allowed_to_access?
      course = current_user.courses.find_by_slug(params[:course_id])

      if course.present?
        course_sections = course.sections.map(&:id)
        user_test_sections = current_user.learners_quizzes.select("distinct section_id").map(&:section_id)
      	exam_active = user_test_sections.each_cons(course_sections.size).include? course_sections

        exam_active ? true : false
      else
        false
      end
    end
end
