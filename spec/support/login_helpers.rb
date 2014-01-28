require 'spec_helper'
include Warden::Test::Helpers


module LoginHelpers
  def create_logged_in_user(type)
    user = Factory(:teacher) if [:teacher, :free_teacher, :paid_teacher].include? type
    user = Factory(:learner) if [:learner, :free_leaner, :paid_leaner].include? type
    user.confirmed_at = Time.now
    user.save
    login(user)
    user
  end

  def login(user)
    login_as user, scope: :user
  end

  def blog_log_in (user=nil)
    user ||= Factory(:blog_user)
    visit blog_admin_login_path
    fill_in "email", with:  user.email
    fill_in "Password", with:  user.password
    click_button "Log in"
    page.should have_content("Logged in!")
  end

  def blog_log_out
    visit blog_admin_path
    click_link "logout"
    page.should have_content("Logged out!")
  end
end

RSpec.configure do |c|
  c.include LoginHelpers, type: :request
end