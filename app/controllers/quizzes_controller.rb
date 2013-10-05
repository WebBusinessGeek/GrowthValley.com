class QuizzesController < ApplicationController
  # GET /quizzes
  # GET /quizzes.json
  def index
    if params[:section_id].present?
      @section = Section.find_by_id(params[:section_id])
      @quizzes = @section.quizzes
    else
      @quizzes = Quiz.all
    end

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /quizzes/1
  # GET /quizzes/1.json
  def show
    if params[:section_id].present?
      @section = Section.find_by_id(params[:section_id])
    end

    @quiz = Quiz.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /quizzes/new
  # GET /quizzes/new.json
  def new
    if params[:section_id].present?
      @section = Section.find_by_id(params[:section_id])
      if @section.quizzes.count < 3
        (3 - @section.quizzes.count).times do
          @quiz = @section.quizzes.build
        end
      else
        if @section.quizzes.size == 10
          redirect_to section_quizzes_path(@section), alert: 'Maximum 10 questions are allowed!'
          return
        else
          @quiz = @section.quizzes.build
          render 'edit'
          return
        end
      end
    else
      @quiz = Quiz.new
    end

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /quizzes/1/edit
  def edit
    if params[:section_id].present?
      @section = Section.find_by_id(params[:section_id])
    end

    @quiz = Quiz.find(params[:id])
  end

  # POST /quizzes
  # POST /quizzes.json
  def create
    if params[:section_id].present?
      @section = Section.find_by_id(params[:section_id])
      @quiz = @section.quizzes.build(params[:quiz])
    else
      @quiz = Quiz.new(params[:quiz])
    end

    respond_to do |format|
      if @quiz.save
        format.html { redirect_to section_quizzes_path(@section), notice: 'Quiz was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /quizzes/1
  # PUT /quizzes/1.json
  def update
    if params[:section_id].present?
      @section = Section.find_by_id(params[:section_id])
    end

    @quiz = Quiz.find(params[:id])

    respond_to do |format|
      if @quiz.update_attributes(params[:quiz])
        format.html { redirect_to section_quizzes_path(@section), notice: 'Quiz was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /quizzes/1
  # DELETE /quizzes/1.json
  def destroy
    if params[:section_id].present?
      @section = Section.find_by_id(params[:section_id])
    end

    @quiz = Quiz.find(params[:id])

    if @section.quizzes.count == 3
      redirect_to section_quizzes_path(@section), alert: 'Atleast 3 questions are required...'
      return
    else
      @quiz.destroy
    end

    respond_to do |format|
      format.html { redirect_to section_quizzes_path(@section) }
    end
  end
end
