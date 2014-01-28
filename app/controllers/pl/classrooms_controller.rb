class Pl::ClassroomsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @requested, @active = [],[]
    @classrooms = current_user.users_classrooms.includes(classroom: [:course]).each do |classroom|
      @requested << classroom if classroom.classroom.requested?
      @active << classroom if classroom.classroom.active?
    end
  end

  def show
    @classroom = Pl::Classroom.find(params[:id])
  end
end