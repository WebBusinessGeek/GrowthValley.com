class CustomFailureAuthentication < Devise::FailureApp
  protected
  #def redirect_url
   # root_path+"?login=1"
  #end
  
  def redirect_url
	  if warden_message == :unconfirmed
		user_inactive_path
	  else
		root_path+"?login=1"
	  end
  end
end
