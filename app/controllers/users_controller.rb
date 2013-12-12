class UsersController < ApplicationController
  before_filter :check_access, except: [:list_subjects, :update_user_subjects, :subscribe_teacher]

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

  def review_exams
    @learners_exams = Subscription.where(progress: 'exam given', user_type: 'Learner', course_id: current_user.subscriptions.where(user_type: 'Teacher').map(&:course_id)).page(params[:page])

    respond_to do |format|
      format.html
    end
  end

  def reviewed_exams
    @learners_exams = Subscription.where(progress: 'exam reviewed', user_type: 'Learner', course_id: current_user.subscriptions.where(user_type: 'Teacher').map(&:course_id)).page(params[:page])

    respond_to do |format|
      format.html
    end
  end

  def exam_review
    if params[:exam_id].present? && params[:user_id].present?
      @learners_exam = LearnersExam.where(exam_id: params[:exam_id], user_id: params[:user_id], score: nil).order('id asc').first

      unless @learners_exam.present?
        redirect_to exam_result_path(exam_id: params[:exam_id], user_id: params[:user_id]), alert: 'All questions have already been reviewed'
      end
    end
  end

  def submit_review
    if params[:learners_exam_id].present?
      learners_exam = LearnersExam.find_by_id(params[:learners_exam_id])
      if learners_exam.present?
        learners_exam.score = params[:score]

        if learners_exam.save
          remaining_questions = LearnersExam.where(exam_id: learners_exam.exam_id, user_id: learners_exam.user_id, score: nil).order('id asc')

          if remaining_questions.present?
            redirect_to review_exam_path(exam_id: learners_exam.exam_id, user_id: learners_exam.user_id), notice: 'Score submitted successfully!'
          else
            redirect_to exam_result_path(exam_id: learners_exam.exam_id, user_id: learners_exam.user_id), notice: 'All questions reviewed successfully!'
          end
        else
          render :new
        end
      end
    end
  end

  def exam_result
    if params[:exam_id].present? && params[:user_id].present?
      @learners_exams = LearnersExam.where(exam_id: params[:exam_id], user_id: params[:user_id]).order('id asc')
      @total_exam_count=LearnersExam.where(exam_id: params[:exam_id], user_id: params[:user_id]).count
      @total_exam_score=LearnersExam.where(exam_id: params[:exam_id], user_id: params[:user_id]).sum('score')
      @total_score_cgpa=@total_exam_score/@total_exam_count
      if(@total_score_cgpa >= "5")
          final_result="passed"
      else
          final_result="failed"
      end
      @exam_reviewed = Subscription.where(user_id: @learners_exams.first.user.id, course_id: @learners_exams.first.course.id).first
      @exam_reviewed[:progress]="exam reviewed"
      @exam_reviewed[:score]=@total_score_cgpa
      @exam_reviewed[:final_result]=final_result
      @exam_reviewed.save
      @suggested_courses = current_user.courses.all_published - Subscription.where(user_type: 'Learner').collect { |s| s.course }
    end
  end

  def submit_result
    if params[:course_id].present? && params[:learner_id].present? && params[:exam_id].present?
      subscription = Subscription.where(course_id: params[:course_id], user_id: params[:learner_id], user_type: 'Learner').order('id asc').first
      subscription.update_attribute(:progress, 'exam reviewed')

      if params[:suggested_courses].present?
        suggested_courses = Array.new

        params[:suggested_courses].each do |cid|
          suggested_courses << RecommendedCourse.create(user_id: params[:learner_id], exam_id: params[:exam_id], course_id: params[:course_id])
        end
      end

      learners_exams = LearnersExam.where(course_id: params[:course_id], user_id: params[:learner_id])

      if learners_exams.present?
        if suggested_courses.present?
          ExamResultMailer.send_message(current_user.id, params[:learner_id], learners_exams, suggested_courses).deliver
        else
          ExamResultMailer.send_message(current_user.id, params[:learner_id], learners_exams).deliver
        end
      end

      add_activity_stream('COURSE', subscription.course, 'result')

      redirect_to review_exams_path, notice: 'Exam reviewed submitted successfully! User has been informed...'
    else
      redirect_to review_exams_path, alert: 'Some error occoured while trying to submit exam review... Please try again later!'
    end
  end

  def subscribe_teacher
    if params[:course_id].present?
      current_user.subscribe_teacher(params[:course_id])

      redirect_to :back, :notice => "Teacher subscribed successfully!"
    else
      redirect_to :back, :alert => "Course not found!"
    end
  end
  def analytics
     @courses = current_user.courses.page(params[:page])
     @total_subscriptions=Subscription.where(:user_type=>"Learner").count
     @total_passed=Subscription.where(:final_result=>"passed").count
     @total_failed=Subscription.where(:final_result=>"failed").count
  end
  private

    def check_access
      unless current_user && current_user.type == 'Teacher'
        redirect_to :back, alert: 'You are not allowed to access this resource!'
      end
    end
end
