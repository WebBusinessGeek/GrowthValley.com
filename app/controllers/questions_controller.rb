class QuestionsController < ApplicationController
  # GET /questions
  # GET /questions.json
  def index
    if params[:section_id].present?
      @section = Section.find_by_id(params[:section_id])
      @questions = @section.questions
    else
      @questions = Question.all
    end

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    if params[:section_id].present?
      @section = Section.find_by_id(params[:section_id])
    end

    @question = Question.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /questions/new
  # GET /questions/new.json
  def new
    if params[:section_id].present?
      @section = Section.find_by_id(params[:section_id])
      @question = @section.questions.build
    else
      @question = Question.new
    end

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /questions/1/edit
  def edit
    if params[:section_id].present?
      @section = Section.find_by_id(params[:section_id])
    end

    @question = Question.find(params[:id])
  end

  # POST /questions
  # POST /questions.json
  def create
    if params[:section_id].present?
      @section = Section.find_by_id(params[:section_id])
    end

    @question = Question.new(params[:question])

    respond_to do |format|
      if @question.save
        format.html { redirect_to new_section_question_answer_path(@question.section_id, @question) }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.json
  def update
    if params[:section_id].present?
      @section = Section.find_by_id(params[:section_id])
    end

    @question = Question.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html { redirect_to section_question_answers_path(@section, @question) }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question = Question.find(params[:id])
    section = @question.section_id
    @question.destroy

    respond_to do |format|
      format.html { redirect_to section_questions_path(section) }
    end
  end
end
