class Pl::LessonsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_classroom, only: [:index, :create]
  before_filter :load_lesson, only: [:show, :edit, :update, :destroy, :complete]

  respond_to :html, :js

  def index
    @lessons = @classroom.lessons
  end

  def show
    @commentable = @lesson
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def new
    @lesson = Pl::Lesson.new
  end

  def edit
  end

  def create
    @lesson = @classroom.lessons.build(params[:pl_lesson])
    if @lesson.save
      respond_with @classroom, location: classroom_path(@classroom), notice: "Lessons succesfully"
    end
  end

  def update
    @lesson.update_attributes(params[:pl_lesson])
    redirect_to @lesson.classroom, notice: "Lesson succesfully updated."
  end

  def destroy
    @lesson.destroy
  end

  def complete
    if current_user == @lesson.classroom.learner
      unless @lesson.completed?
        @lesson.update_attributes(completed: true)
        msg = "Lesson completed. Well done."
      else
        @lesson.update_attributes(completed: false)
        msg = "Lesson marked uncomplete."
      end
      redirect_to classroom_path(@lesson.classroom), notice: msg
    else
      redirect_to classroom_path(@lesson.classroom), warning: "You are not authorized to do this."
    end
  end

  def add_comment
    @commentable = Pl::Lesson.find(params[:lesson_id])
    @comment = @commentable.comments.new(params[:comment])
    @comment.user = current_user
    if @comment.save!
      redirect_to lesson_path(@commentable), notice: "Comment created."
    else
      redirect_to lesson_path(@commentable), notice: "Failed to create comment"
    end
  end

  def sort
    params[:pl_lesson].each_with_index do |id, index|
        pu = Pl::Lesson.find id
        pu.update_attribute :position, index if pu
    end
    render nothing: true
  end

  private
    def load_classroom
      @classroom = Pl::Classroom.find(params[:classroom_id])
    end

    def load_lesson
      @lesson = Pl::Lesson.find(params[:id])
    end
end