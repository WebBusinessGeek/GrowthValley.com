class HomesController < ApplicationController
  before_filter :authenticate_user!
  skip_before_filter :authenticate_user!, except: [:dashboard, :notification]
  layout :set_layout

  def notification
    @notifications = get_activity_stream(0)
    render :layout => 'application'
  end

  def dashboard
	if current_user.type == "Teacher"
		redirect_to root_url()
		return
	end
    @show_top_menu = false
    @notifications = get_activity_stream(10)
    @my_subjects = current_user.subjects
    if current_user.subjects.present?
    @other_subjects = Subject.where("id not in (?)",current_user.subjects.map(&:id))
    else
    @other_subjects = Subject.all
    end
    render :layout => 'application'
  end
  
  def index
    if current_user && current_user.type == 'Learner'
		redirect_to dashboard_path()
		return
    else
		@current_menu = "home"
		if !current_user
		  @courses = Course.all_published.page(params[:page])
		elsif current_user.type == 'Teacher'
		  @courses = Course.all_published.page(params[:page])
		elsif current_user.type == 'Learner'
		  @courses = Course.all_published_courses_for_subjects(current_user.subjects).page(params[:page])
		end
	end
  end

  def about_us
    @current_menu = "about_us"
    @show_top_menu = true
    render :layout => 'application'
  end
  
  def products
    @current_menu = "products"
    @show_top_menu = true
    render :layout => 'application'
  end
  
  def resources
    @current_menu = "resources"
    @show_top_menu = true
    render :layout => 'application'
  end
  
  def blog
    @current_menu = "blog"
    @show_top_menu = true
    render :layout => 'application'
  end
  
  def contact
    @current_menu = "contact"
    @show_top_menu = true
    render :layout => 'application'
  end
  
  def terms
    @show_top_menu = true
    render :layout => 'application'
  end
  
  def information
    @show_top_menu = true
    render :layout => 'application'
  end
  
  def for_organizations
    @show_top_menu = true
    render :layout => 'application'
  end
  
  def for_people
    @show_top_menu = true
    render :layout => 'application'
  end
  
  def faq
    @show_top_menu = true
    render :layout => 'application'
  end
  
  def how_it_works
    @show_top_menu = true
    render :layout => 'application'
  end
  
  private

  def set_layout
    current_user ? 'user_home' : 'home'
  end
end
