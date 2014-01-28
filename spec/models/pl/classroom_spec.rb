require 'spec_helper'

describe Pl::Classroom do
  let(:classroom) { FactoryGirl.build_stubbed(:classroom) }

  it "should be valid" do
    classroom.should be_valid
  end

  it { should validate_presence_of(:course_id) }

  it 'should have an initial state of requested' do
    classroom.state.should == 'requested'
  end

  it "#learner should return a learner" do
    classroom = FactoryGirl.build(:classroom)
    learner = FactoryGirl.build(:learner)
    classroom.users << learner
    classroom.save
    classroom.learner.should == learner
  end

    it "#teacher should return a teacher" do
      classroom = FactoryGirl.build(:classroom)
      teacher = FactoryGirl.build(:teacher)
      classroom.users << teacher
      classroom.save
      classroom.teacher.should == teacher
    end

  describe "#approve" do
    it "should set state to active when approve is called" do
      classroom = FactoryGirl.create(:classroom)
      teacher = FactoryGirl.create(:teacher)
      learner = FactoryGirl.create(:learner)
      classroom.approve!
      classroom.state.should == 'active'
    end
  end

  describe 'course setting methods' do
    let(:classroom) {FactoryGirl.build_stubbed(:classroom) }

    it { should respond_to(:price_per_lesson) }
    it { should respond_to(:max_number_lessons) }

    it "#price_per_lesson should return a number in cents" do
      classroom.price_per_lesson.should be_kind_of Fixnum
    end

    it "#max_number_lessons should return an integer" do
      classroom.max_number_lessons.should be_kind_of Fixnum
    end
  end
end
