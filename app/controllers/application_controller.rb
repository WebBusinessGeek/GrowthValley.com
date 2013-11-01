class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  def after_sign_in
    if current_user
      if current_user.type == 'Learner'
        redirect_to learners_path
      end
    end
  end
end
