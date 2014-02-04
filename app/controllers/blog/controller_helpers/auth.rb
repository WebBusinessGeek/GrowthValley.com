require 'active_support/concern'

module Blog
  module ControllerHelpers
    module Auth
      extend ActiveSupport::Concern
      include Blog::ControllerHelpers::User

      included do
        before_filter :blog_authenticate_user!
      end

      private
      def blog_authenticate_user!
         if blog_current_user.nil?
           redirect_to blog_admin_login_url, alert: I18n.t("blog.admin.login.need_auth")
         end
      end

      def require_blog_admin
        redirect_to blog_admin_path, notice: "You must be a blog administrator to do this" unless blog_current_user.admin?
      end
    end
  end
end