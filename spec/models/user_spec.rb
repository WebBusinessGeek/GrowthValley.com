require 'spec_helper'

describe User do
  before(:each) do
    @user = Factory(:user)
  end

  it { validate_presence_of :full_name }
  it { validate_presence_of :type }
end