require 'spec_helper'

describe Pl::ClassroomsController, type: :controller do
  context 'teacher' do
    login_as_teacher

    it 'get #index' do
      get :index
      response.should be_success
    end

    it 'get #show' do
      classroom = FactoryGirl.create(:classroom)
      # current_user.classrooms << classroom
      get :show, id: classroom
      assigns(:classroom).should == classroom
    end
  end
  context 'learner' do
    login_as_learner

    it 'get #index' do
      get :index
      response.should be_success
    end

    it 'get #show' do
      classroom = FactoryGirl.create(:classroom)
      # current_user.classrooms << classroom
      get :show, id: classroom
      assigns(:classroom).should == classroom
    end
  end
end