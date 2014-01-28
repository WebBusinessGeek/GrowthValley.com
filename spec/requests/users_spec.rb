require 'spec_helper'
describe User do
  context 'teacher' do
    it "logged in should be able to logout" do
      user = create_logged_in_user :paid_teacher
      visit user_subjects_path
      page.should have_content("Log Out")
    end
  end
end