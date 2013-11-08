class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    extra = Hash.new()
    extra['type'] = request.env["omniauth.params"]["as"]
    @user = User.find_for_oauth(request.env["omniauth.auth"], extra, current_user)

    if @user.persisted?
      sign_in @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      #if @user.type != extra['type']
		#flash[:notice] = flash[:notice] + " test"
      #end
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
    end
    redirect_to root_url
  end
  
  def after_omniauth_failure_path_for(scope)
    root_path()
  end
end
