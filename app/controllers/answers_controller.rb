class AnswersController < ApplicationController
  # GET /answers
  # GET /answers.json
  def index
    if params[:section_id].present?
      @section = Section.find_by_id(params[:section_id])
    end

    if params[:question_id].present?
      @question = Question.find_by_id(params[:question_id])
      @answers = @question.answers
    else
      @answers = Answer.all
    end

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
    if params[:section_id].present?
      @section = Section.find_by_id(params[:section_id])
    end

    if params[:question_id].present?
      @question = Question.find_by_id(params[:question_id])
    end

    @answer = Answer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /answers/new
  # GET /answers/new.json
  def new
    if params[:section_id].present?
      @section = Section.find_by_id(params[:section_id])
    end

    if params[:question_id].present?
      @question = Question.find_by_id(params[:question_id])
      @answer = @question.answers.build
    else
      @answer = Answer.new
    end

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /answers/1/edit
  def edit
    if params[:section_id].present?
      @section = Section.find_by_id(params[:section_id])
    end

    if params[:question_id].present?
      @question = Question.find_by_id(params[:question_id])
    end

    @answer = Answer.find(params[:id])
  end

  # POST /answers
  # POST /answers.json
  def create
    if params[:section_id].present?
      @section = Section.find_by_id(params[:section_id])
    end

    if params[:question_id].present?
      @question = Question.find_by_id(params[:question_id])
    end

    @answer = Answer.new(params[:answer])

    respond_to do |format|
      if @answer.save
        format.html { redirect_to course_path(@section.course_id), notice: 'Answer was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /answers/1
  # PUT /answers/1.json
  def update
    if params[:section_id].present?
      @section = Section.find_by_id(params[:section_id])
    end

    if params[:question_id].present?
      @question = Question.find_by_id(params[:question_id])
    end

    @answer = Answer.find(params[:id])

    respond_to do |format|
      if @answer.update_attributes(params[:answer])
        format.html { redirect_to course_path(@section.course_id), notice: 'Answer was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer = Answer.find(params[:id])
    question = @answer.question_id
    section = Question.find_by_id(question).section_id
    @answer.destroy

    respond_to do |format|
      format.html { redirect_to section_question_answers_path(section, question) }
    end
  end
end
