class ApplicationController < ActionController::Base
  require "activitystream"
  include Activitystream
  protect_from_forgery

  before_filter :update_sanitized_params, if: :devise_controller?

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:full_name,:email, :password, :type)}
  end
end
