class ExamsController < ApplicationController
  # GET /exams
  # GET /exams.json
  def index
    @course = Course.find_by_slug(params[:course_id])
    @exam = @course.exam

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /exams/1
  # GET /exams/1.json
  def show
    @course = Course.find_by_slug(params[:course_id])
    @exam = @course.exam

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /exams/new
  # GET /exams/new.json
  def new
    @course = Course.find_by_slug(params[:course_id])
    @exam = @course.build_exam

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /exams/1/edit
  def edit
    @course = Course.find_by_slug(params[:course_id])
    @exam = @course.exam
  end

  # POST /exams
  # POST /exams.json
  def create
    @course = Course.find_by_slug(params[:course_id])
    @exam = @course.build_exam(params[:exam])

    respond_to do |format|
      if @exam.save
        format.html { redirect_to course_exam_path(@course, @exam), notice: 'Exam was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /exams/1
  # PUT /exams/1.json
  def update
    @course = Course.find_by_slug(params[:course_id])
    @exam = @course.exam

    respond_to do |format|
      if @exam.update_attributes(params[:exam])
        format.html { redirect_to course_exam_path(@course, @exam), notice: 'Exam was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /exams/1
  # DELETE /exams/1.json
  def destroy
    @course = Course.find_by_slug(params[:course_id])
    @exam = @course.exam
    @exam.destroy

    respond_to do |format|
      format.html { redirect_to course_exams_path(@course) }
    end
  end
end
