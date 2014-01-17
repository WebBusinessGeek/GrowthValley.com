class Blog::Admin::BaseController < Blog::ApplicationController
  include Blog::ControllerHelpers::Auth

  layout "layouts/blog/admin"
end