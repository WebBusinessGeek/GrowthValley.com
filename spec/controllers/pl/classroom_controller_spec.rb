require 'spec_helper'

describe Pl::ClassroomsController, type: :controller do
  context 'teacher' do
    login_as_teacher
  end
  context 'learner' do
    login_as_learner
  end
end