class Blog::Admin::SessionsController < Blog::Admin::BaseController
  skip_before_filter :blog_authenticate_user!

  def new
  end

  def create
    user = Blog::User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:blog_user_id] = user.id
      redirect_to blog_admin_url, notice: t("blog.admin.sessions.messages.logged_in")
    else
      flash.now.alert = t("blog.admin.sessions.messages.invalid")
      render "new"
    end
  end

  def destroy
    session[:blog_user_id] = nil
    redirect_to blog_admin_url, notice: t("blog.admin.sessions.messages.logged_out")
  end
end