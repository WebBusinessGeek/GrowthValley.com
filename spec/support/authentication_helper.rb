module Blog
  module AuthenticationMock
    def sign_in_as user
      session[:blog_user_id] = user.id
    end
  end
end

module ControllerMacros
  def login_as_teacher
   before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:teacher)
      user.confirm!
      sign_in user
    end
  end

  def login_as_learner
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:learner)
      user.confirm!
      sign_in user
    end
  end
end

# Not sure why I had to split the modules but... wth
RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.include Blog::AuthenticationMock, type: :controller
  config.extend ControllerMacros, type: :controller
end