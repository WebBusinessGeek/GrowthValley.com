class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    extra = Hash.new()
    extra['type'] = request.env["omniauth.params"]["as"]

    auth = request.env["omniauth.auth"]
    user = User.where(:provider => auth.provider, :uid => auth.uid)

    unless user.present?
      @user = User.find_for_oauth(auth, extra, current_user)

      if @user.persisted?
        sign_in @user, :event => :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      else
        session["devise.facebook_data"] = request.env["omniauth.auth"]
      end
    else
      if user.first.type == 'Learner'
        flash[:alert] = 'You are already registered with GrowthValley as Learner!'
      else
        flash[:alert] = 'You are already registered with GrowthValley! as Teacher'
      end
    end

    redirect_to root_url
  end
  
  def after_omniauth_failure_path_for(scope)
    root_path()
  end
end
