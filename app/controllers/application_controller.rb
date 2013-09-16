class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_mailer_url_options, :authenticate_user!

  def set_mailer_url_options
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end
end
