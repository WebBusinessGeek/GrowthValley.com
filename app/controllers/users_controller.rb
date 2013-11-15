class UsersController < ApplicationController
  before_filter :check_access, except: [:list_subjects, :update_user_subjects]

  def list_subjects
    @subjects = Subject.all
  end

  def update_user_subjects
    if params[:user].present? && params[:user][:subject_ids].present?
      if params[:user][:subject_ids].length > 3 || current_user.subjects.count == 3
        redirect_to user_subjects_path, alert: 'Maximum 3 subjects can be added...'
      else
        params[:user][:subject_ids].collect do |subj|
          s = Subject.find_by_id(subj)
          current_user.subjects.push(s) unless current_user.subjects.include?(s)
        end
        redirect_to my_courses_courses_path, notice: 'Subjects added successfully!'
      end
    else
      redirect_to user_subjects_path, alert: 'You must subscribe to atleast one subject...'
    end
  end

  def my_exams
    @learners_exams = current_user.exams_for_review
    @exams = Array.new

    @learners_exams.each do |le|
      @exams << le.exam
    end

    respond_to do |format|
      format.html
    end
  end

  def exam_review
    if params[:exam_id].present?
      exam = Exam.find_by_id(params[:exam_id])

      if exam.present?
        @learners_exam = LearnersExam.where(exam_id: exam.id, score: nil).order('id asc').first

        unless @learners_exam.present?
          redirect_to exam_result_path(exam_id: exam.id), alert: 'All questions have already been reviewed'
        end
      end
    end
  end

  def submit_review
    if params[:learners_exam_id].present?
      learners_exam = LearnersExam.find_by_id(params[:learners_exam_id])
      if learners_exam.present?
        learners_exam.score = params[:score]

        if learners_exam.save
          remaining_questions = LearnersExam.where(exam_id: learners_exam.exam.id, score: nil).order('id asc')

          if remaining_questions.present?
            redirect_to review_exam_path(exam_id: learners_exam.exam.id), notice: 'Score submitted successfully!'
          else
            redirect_to exam_result_path(exam_id: learners_exam.exam.id), notice: 'All questions reviewed successfully!'
          end
        else
          render :new
        end
      end
    end
  end

  def exam_result
    if params[:exam_id].present?
      exam = Exam.find_by_id(params[:exam_id])

      if exam.present?
        @learners_exams = LearnersExam.where(exam_id: exam.id).order('id asc')
      end
    end
  end

  def submit_result
    if params[:course_id].present? && params[:learner_id].present? && params[:exam_id].present? && params[:suggested_courses].present?
      subscription = Subscription.where(course_id: params[:course_id], user_id: params[:learner_id], user_type: 'Learner').order('id asc').first
      subscription.update_attribute(:progress, 'exam reviewed')

      params[:suggested_courses].each do |cid|
        RecommendedCourse.create(user_id: params[:learner_id], exam_id: params[:exam_id], course_id: params[:course_id])
      end

      ## code to send mail to learner will come here...

      redirect_to my_exams_path, notice: 'Exam reviewed submitted successfully! User has been informed...'
    else
      redirect_to my_exams_path, alert: 'Some error occoured while trying to submit exam review... Please try again later!'
    end
  end

  private

    def check_access
      unless current_user && current_user.type == 'Teacher'
        redirect_to :back, alert: 'You are not allowed to access this resource!'
      end
    end
end
