class Pl::ClassroomsController < ApplicationController
  before_filter :authenticate_user!

  def index
    if params[:course]
      @course = Course.find_by_slug(params[:course])
      @classrooms = Pl::UsersClassroom.where(classroom_id: @course.classroom_ids, user_id: current_user.id)
    else
      @classrooms = current_user.users_classrooms.includes(classroom: [:course])
    end
    @requests = Pl::ClassroomRequest.where(course_id: current_user.course_ids).incompleted if current_user.type == "Teacher"
    @requests = current_user.classroom_requests.incompleted if current_user.type == "Learner"
  end

  def show
    @classroom = Pl::Classroom.find(params[:id])
    if @classroom.privacy? && !@classroom.users.include?(current_user)
      redirect_to root_path, notice: "You cannot view a private classroom"
    end
  end

  def edit
    if params[:course_id]
      @course = Course.find(params[:course_id])
      @classroom = @course.classroom
    else
      @classroom = Pl::Classroom.find(params[:id])
    end
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

  def sort
    params[:pl_users_classroom].each_with_index do |id, index|
        pu = current_user.users_classrooms.find id
        pu.update_attribute :position, index if pu
    end
    render nothing: true
  end

  def toggle_privacy
    @classroom = Pl::Classroom.find(params[:id])
    if @classroom.privacy?
      @classroom.update_attributes privacy: false
    else
      @classroom.update_attributes privacy: true
    end
    redirect_to classroom_path @classroom
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