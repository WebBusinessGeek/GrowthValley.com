class Pl::ClassroomRequestsController < ApplicationController
  def index
  end
  def new
    @course = Course.find(params[:course_id])
    @request = Pl::ClassroomRequest.new(course_id: @course.id, learner_id: current_user.id)
    @request.comments.build
  end

  def create
    @request = Pl::ClassroomRequest.new(params[:pl_classroom_request])
    if @request.save
      redirect_to course_path(@request.course), notice: "Request sent successfully."
    else
      render action: :new
    end
  end

  def edit
    @request = Pl::ClassroomRequest.find(params[:id])
    check_authorization
  end

  def update
    @request = Pl::ClassroomRequest.find(params[:id])
    check_authorization
    if @request.update_attributes(params[:pl_classroom_request])
      redirect_to classrooms_path, notice: "Request successfully updated."
    else
      render action: :edit
    end
  end

  def destroy
    @request = Pl::ClassroomRequest.find(params[:id])
    check_authorization
    @request.destroy
  end

  def approve
    @request = Pl::ClassroomRequest.find(params[:id])
    check_authorization
    @request.update_attribute("#{current_user.type.downcase}_approved".to_sym, true)
    if @request.final_approval?
      if current_user.type == "Teacher"
        msg = "Approval submitted. Awaiting payment from other party."
      else
        msg = "Both parties have approved your classroom request. Please make payment by clicking the pay button below."
      end
      redirect_to classrooms_path, notice: msg
    end
  end

  def pay
    @request = Pl::ClassroomRequest.find(params[:id])
    unauthorized if current_user != @request.learner
    # future pay code
    @classroom = Pl::Classroom.add_classroom({
      "course_id" => @request.course_id,
      "learner_id" => @request.learner_id,
      "active" => true
    })
    if @classroom
      redirect_to classroom_path(@classroom), notice: "Payment recieved and classroom created successfully."
    else
      redirect_to classrooms_path, warn: "Payment request unsuccessful."
    end
  end

  private
    def check_authorization
      unauthorized unless current_user == @request.learner || current_user == @request.course.teacher
    end

    def unauthorized
      redirect_to classrooms_path, warn: "Not authorized."
    end
end