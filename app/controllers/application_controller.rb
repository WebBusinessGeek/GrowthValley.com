class ApplicationController < ActionController::Base
  require "activitystream"
  include Activitystream
  protect_from_forgery
  before_filter :authenticate_user!
end
