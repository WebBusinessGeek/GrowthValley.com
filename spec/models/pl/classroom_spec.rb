require 'spec_helper'

describe Pl::Classroom do
  let(:classroom) { FactoryGirl.build_stubbed(:classroom) }

  it "should be valid" do
    classroom.should be_valid
  end
end
