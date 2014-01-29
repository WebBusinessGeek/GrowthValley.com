class Pl::LessonsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_classroom, only: [:index, :create]
  before_filter :load_lessons, only: [:show, :edit, :update, :destroy]

  respond_to :html, :js

  def index
    @lessons = @classroom.lessons
  end

  def show
  end

  def new
    @lesson = Pl::Lesson.new
  end

  def edit
  end

  def create
    @lesson = @classroom.lessons.build(params[:lesson])
    if @lesson.save
      respond_with @lesson
    end
  end

  def update
    @lesson.update_attributes(params[:lesson])
    redirect_to @lesson.classroom, notice: "Lesson succesfully updated."
  end

  def destroy
    @lesson.destroy
  end

  def complete
    @lesson.update_attributes state: "done" if params["checked"] == "true"
    @lesson.update_attributes state: "to_do" if params["checked"] == "false"
  end

  private
    def load_classroom
      @classroom = Pl::Classroom.find(params[:classroom_id])
    end

    def load_lesson
      @lesson = Pl::Lesson.find(params[:id])
    end
end