class Pl::ClassroomsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @requested, @active = [],[]
    if params[:course]
      @course = Course.find_by_slug(params[:course])
      @classrooms = Pl::UsersClassroom.where(classroom_id: @course.classroom_ids, user_id: current_user.id)
    else
      @classrooms = current_user.users_classrooms.includes(classroom: [:course])
    end
    @classrooms.each do |classroom|
      @requested << classroom if classroom.classroom.requested?
      @active << classroom if classroom.classroom.active?
    end
  end

  def show
    @classroom = Pl::Classroom.find(params[:id])
  end

  def edit
    @classroom = Pl::Classroom.find(params[:id])
  end

  def update
    @classroom = Pl::Classroom.find(params[:id])
    if @classroom.update_attributes(params[:classroom])
      redirect_to classroom_path(@classroom), notice: "Classroom successfully updated"
    else
      render :edit
    end
  end

  def create
    @classroom = Pl::Classroom.add_classroom(params[:classroom])

    if @classroom
      redirect_to classrooms_path, success: "Classroom successfully requested."
    else
      redirect :back, notice: "Error creating request."
    end
  end

  def approve
    @classroom = Pl::Classroom.find(params[:classroom_id])
    if @classroom.teacher != current_user
      redirect_to :back, notice: "Not authorized"
    else
      unless @classroom.active?
        @classroom.approve!
        redirect_to edit_classroom_path(@classroom)
      end
    end
  end
end