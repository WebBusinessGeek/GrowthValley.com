class CoursesController < ApplicationController
  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @course = Course.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /courses/new
  # GET /courses/new.json
  def new
    @course = Course.new
    @course.sections.build

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find(params[:id])
    @course.sections.build
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(params[:course])

    respond_to do |format|
      if @course.save
        # format.html { redirect_to @course, notice: 'Course was successfully created.' }
        session[:course_id] = @course.id
        format.html { redirect_to course_steps_path }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /courses/1
  # PUT /courses/1.json
  def update
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        # format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        session[:course_id] = @course.id
        format.html { redirect_to course_steps_path }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url }
    end
  end

  def publish_unpublish
    course = Course.find_by_id(params[:id])
    if course.present?
      if course.togglePublish == true
        render json: { status: 'success', data: course.is_published }
      else
        render json: { status: 'error', errorCode: '400', data: 'Error! Each section must have a test...' }
      end
    else
      render json: { status: 'error', errorCode: '404', data: 'Course not found!' }
    end
  end
end
