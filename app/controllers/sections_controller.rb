class SectionsController < ApplicationController
  # GET /sections
  # GET /sections.json
  def index
    if params[:course_id].present?
      @course = Course.find_by_id(params[:course_id])
      @sections = @course.sections
    else
      @sections = Section.all
    end

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /sections/1
  # GET /sections/1.json
  def show
    @section = Section.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /sections/new
  # GET /sections/new.json
  def new
    if params[:course_id].present?
      @course = Course.find_by_id(params[:course_id])
      @section = @course.sections.build
    else
      @section = Section.new
    end

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /sections/1/edit
  def edit
    @section = Section.find(params[:id])
  end

  # POST /sections
  # POST /sections.json
  def create
    @section = Section.new(params[:section])

    respond_to do |format|
      if @section.save
        format.html { redirect_to @section, notice: 'Section was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /sections/1
  # PUT /sections/1.json
  def update
    @section = Section.find(params[:id])

    respond_to do |format|
      if @section.update_attributes(params[:section])
        format.html { redirect_to @section, notice: 'Section was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /sections/1
  # DELETE /sections/1.json
  def destroy
    if params[:course_id].present?
      @course = Course.find_by_id(params[:course_id])
    end

    @section = Section.find(params[:id])
    @section.destroy

    respond_to do |format|
      format.html { redirect_to sections_path(course_id: @course) }
    end
  end
end
