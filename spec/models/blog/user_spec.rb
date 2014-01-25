require 'spec_helper'

describe Blog::User do
  it { validate_presence_of(:name) }
  it { validate_presence_of(:email) }
  it { validate_uniqueness_of(:email) }

  context "delete user" do
    let(:user_without_post) { stub_model(Blog::User) }
    let(:user_with_post) do
      user = stub_model(Blog::User)
      user.stub(:posts => [stub_model(Blog::Post)])
      user
    end

    let(:user) { Blog::User.new }

    it "should not be able to delete itself" do
      user.can_delete?(user).should be_false
    end

    it "should not be able to delete a user with posts" do
      user.can_delete?(user_with_post).should be_false
    end
  end
end
