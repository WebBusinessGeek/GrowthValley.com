class ExamQuestionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_user, :check_subscribers

  # GET /exam_questions
  # GET /exam_questions.json
  def index
    @exam = Exam.find_by_id(params[:exam_id])
    @exam_questions = @exam.exam_questions

    respond_to do |format|
      format.html{ render :layout => 'home_new'} # index.html.erb
    end
  end

  # GET /exam_questions/1
  # GET /exam_questions/1.json
  def show
    @exam = Exam.find_by_id(params[:exam_id])
    @exam_question = @exam.exam_questions.find_by_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /exam_questions/new
  # GET /exam_questions/new.json
  def new
    @exam = Exam.find_by_id(params[:exam_id])

    if @exam.exam_questions.count == (@exam.course.sections.count * 10)
      redirect_to course_exam_exam_questions_path(@exam.course, @exam), alert: "Maximum #{@exam.course.sections.count * 10} questions are allowed!"
     
      return
    elsif @exam.exam_questions.present? && @exam.exam_questions.count >= 3
      @exam_question = @exam.exam_questions.build
      @edit = true
      #render :add
      #return
    else
      @edit = false
      3.times do
        @exam_question = @exam.exam_questions.build
      end
    end

    respond_to do |format|
      format.html{render :layout => 'home_new'} # new.html.erb
    end
  end

  # GET /exam_questions/1/edit
  def edit
    @exam = Exam.find_by_id(params[:exam_id])
    @exam_question = @exam.exam_questions.find_by_id(params[:id])
    render :layout => 'home_new'
  end

  # POST /exam_questions
  # POST /exam_questions.json
  def create
    @exam = Exam.find_by_id(params[:exam_id])
    @exam_question = @exam.exam_questions.build(params[:exam_question])
    respond_to do |format|
      if @exam_question.save
        format.html { redirect_to course_exam_exam_questions_path(@exam.course, @exam), notice: 'Exam question was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /exam_questions/1
  # PUT /exam_questions/1.json
  def update
    @exam = Exam.find_by_id(params[:exam_id])
    @exam_question = @exam.exam_questions.find_by_id(params[:id])

    respond_to do |format|
      if @exam_question.update_attributes(params[:exam_question])
        format.html { redirect_to course_exam_exam_questions_path(@exam.course, @exam), notice: 'Exam question was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /exam_questions/1
  # DELETE /exam_questions/1.json
  def destroy
    @exam = Exam.find_by_id(params[:exam_id])
    @exam_question = @exam.exam_questions.find_by_id(params[:id])

    if @exam.exam_questions.count == 3
      redirect_to course_exam_exam_questions_path(@exam.course, @exam), alert: 'Atleast 3 questions are required...'
      return
    else
      @exam_question.destroy
    end

    respond_to do |format|
      format.html { redirect_to course_exam_exam_questions_path(@exam.course, @exam), notice: 'Question deleted successfully!' }
    end
  end

  private

    def authorize_user
      redirect_to my_courses_courses_path, alert: 'You are not allowed to access this section!' unless current_user.type == 'Teacher'
    end

    def check_subscribers
      course = current_user.courses.find(params[:course_id])

      if course.present?
        if course.has_active_learners?
          redirect_to my_courses_courses_path, alert: 'You are not allowed to modify exam question for a course which has active subscriptions!'
        end
      else
        redirect_to my_courses_courses_path, alert: 'The course you are trying to access, could not found!'
      end
    end
end
