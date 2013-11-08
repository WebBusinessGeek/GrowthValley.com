class HomesController < ApplicationController
  skip_before_filter :authenticate_user!
  layout :set_layout

  def index
    @current_menu = "home"
    if params[:search].present?
		if !current_user
		  @courses = Course.all_published.text_search(params)
		elsif current_user.type == 'Teacher'
		  @courses = Course.all_published.text_search(params)
		elsif current_user.type == 'Learner'
		  @courses = Course.all_published_courses_for_subjects(current_user.subjects).text_search(params)
		end
	else
		if !current_user
		  @courses = Course.all_published
		elsif current_user.type == 'Teacher'
		  @courses = Course.all_published
		elsif current_user.type == 'Learner'
		  @courses = Course.all_published_courses_for_subjects(current_user.subjects)
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
  
  private

  def set_layout
    current_user ? 'application' : 'home'
  end
end
