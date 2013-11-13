class CustomFailureAuthentication < Devise::FailureApp
  protected
  def redirect_url
    root_path+"?login=1"
  end
end
