module BlogSpecHelper
  module AuthenticationMock
    def sign_in_as user
      session[:blog_user_id] = user.id
    end
  end
end

RSpec.configure do |config|
  config.include BlogSpecHelper::AuthenticationMock, type: :controller
end