class Blog::Admin::UsersController < Blog::Admin::BaseController

  before_filter :load_user, except: [:index, :new, :create]
  before_filter :require_blog_admin, except: [:update, :edit]

  def edit
    if (blog_current_user != @user) && !blog_current_user.admin?
      redirect_to blog_admin_path, notice: "You are not authorized for this page"
    end
  end

  def new
    @user = Blog::User.new
  end

  def update
    if @user.update_attributes user_params
      flash.notice = "User modified"
      redirect_to blog_admin_path
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to blog_admin_users_path, notice:  I18n.t("blog.admin.users.delete.removed", user: @user.name)
    else
      redirect_to blog_admin_users_path, alert: I18n.t("blog.admin.users.delete.failed", user: @user.name)
   end
  end

  def create
    @user = Blog::User.new user_params
    if @user.save
      flash.notice = I18n.t("blog.admin.users.create.success")
      redirect_to blog_admin_users_path
    else
      render :new
    end
  end

  def index
    @users = Blog::User.all
  end

  private
    def load_user
      @user = Blog::User.find(params[:id])
    end

    def user_params
      params.require(:blog_user).permit(:name, :email, :password, :password_confirmation)
    end
end