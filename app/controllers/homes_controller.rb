class HomesController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
    @courses = Course.all_published
  end
end