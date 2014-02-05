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
      render :create
    else
      render action: :new
    end
  end
  def edit
  end
  def update
  end
  def destroy
  end
end