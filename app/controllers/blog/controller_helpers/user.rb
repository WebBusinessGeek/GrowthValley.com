require 'active_support/concern'

module Blog
  module ControllerHelpers
    module User
      extend ActiveSupport::Concern

      included do
        helper_method :blog_current_user
      end

      private
      def blog_current_user
        @blog_current_user ||= Blog::User.find(session[:blog_user_id]) if session[:blog_user_id]
      end
    end
  end
end