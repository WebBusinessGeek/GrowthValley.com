require 'spec_helper'

describe Course do
  let(:course) { FactoryGirl.build_stubbed(:course) }

  describe 'classroom' do
    it "should be disabled by default" do
      course.classroom_enabled.should be_false
    end

    describe 'classroom_properties should store classroom related metadeta' do
      it { should respond_to(:cost_per_lesson) }
      it { should respond_to(:max_number_lessons) }
      it { should respond_to(:private_classroom) }
    end
  end
end