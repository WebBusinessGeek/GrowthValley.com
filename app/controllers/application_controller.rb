class ApplicationController < ActionController::Base
  require "activitystream"
  include Activitystream
  protect_from_forgery
end
