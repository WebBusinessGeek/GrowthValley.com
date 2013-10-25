class HomesController < ApplicationController
  skip_before_filter :authenticate_user!
  layout 'home'

  def index
    if !current_user
      @courses = Course.all_published
    elsif current_user.type == 'Teacher'
      @courses = Course.all_published
    elsif current_user.type == 'Learner'
      @courses = Course.all_published_courses_for_subjects(current_user.subjects)
    end
  end
end
