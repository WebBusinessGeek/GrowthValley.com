require 'spec_helper'
module LoginHelpers
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