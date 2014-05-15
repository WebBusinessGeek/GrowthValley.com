class CoursesController < ApplicationController
  before_filter :authenticate_user!
  skip_before_filter :authenticate_user!, only: [:rate_course, :index]
  before_filter :authorize_user, :check_subscribers, only: [:edit, :update, :destroy, :sections]

  # GET /courses
  # GET /courses.json
  def index
    @current_menu = "courses"
    @show_top_menu = true
    if params[:order].present?
		if params[:order] == "latest"
			sort_order = "courses.created_at desc"
		elsif params[:order] == "name"
			sort_order = "courses.title asc"
		elsif params[:order] == "rating"
			sort_order = "courses.created_at asc"
		else
			sort_order = "courses.title asc"
		end
	else
		sort_order = "courses.title asc"
    end
    
   if params[:subject].present?
		current_subject = Subject.find_all_by_slug(params[:subject])
   else
		current_subject = Subject.all
   end
   if params[:search].present?
		if params[:order].present?
			@courses = Course.all_published_courses_for_subjects(current_subject).text_search(params).reorder(sort_order).page(params[:page])
		else
			@courses = Course.all_published_courses_for_subjects(current_subject).text_search(params).page(params[:page])
		end
   else
		@courses = Course.all_published_courses_for_subjects(current_subject).order(sort_order).page(params[:page])
   end
   
=begin  
    if params[:search].present?
		if !current_user
		  @courses = Course.all_published.text_search(params).order(sort_order)
		elsif current_user.type == 'Teacher'
		  @courses = Course.all_published.text_search(params).order(sort_order)
		elsif current_user.type == 'Learner'
		  @courses = Course.all_published_courses_for_subjects(current_user.subjects).text_search(params).order(sort_order)
		end
	else
		if !current_user
		  @courses = Course.all_published.order(sort_order)
		elsif current_user.type == 'Teacher'
		  @courses = Course.all_published.order(sort_order)
		elsif current_user.type == 'Learner'
		  @courses = Course.all_published_courses_for_subjects(current_user.subjects).order(sort_order)
		end
	end
=end
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def my_courses
    @course = current_user.courses.build
    @course.sections.build

    @courses = current_user.courses.page(params[:page])
    render layout: 'home_new'
  end

  # GET /courses/1
  # GET /courses/1.json
  def sections
    @course = current_user.courses.find_by_slug(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @course = Course.find_by_slug(params[:id])
    @current_subscription = @course.subscriptions.where("user_id = ?", current_user.id).first
	  @total_section = @course.sections.count
	  @learners_exams = LearnersExam.where(user_id: current_user.id, course_id: @course.id)

	  course_sections = @course.sections.map(&:id)
	  user_test_sections = current_user.learners_quizzes.select("distinct section_id").map(&:section_id)
	  @exam_active = user_test_sections.each_cons(course_sections.size).include? course_sections
	  @progress = @current_subscription.present? ? @current_subscription.progress : ""
	  @progress_percentage = @current_subscription.present? ? @current_subscription.progress_percentage : "0"
	  
	  if @course.is_published?	
		  respond_to do |format|
		    format.html # show.html.erb
		  end
	  else
		  if @current_subscription.present? and @current_subscription.user_type == "Teacher"
			  respond_to do |format|
			    format.html # show.html.erb
			  end		
		  else
			  redirect_to :dashboard, :notice => "The desired course is un-published."
		  end
	  end
  end

  # GET /courses/new
  # GET /courses/new.json
  def new
    @course = current_user.courses.build
    @course.sections.build

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /courses/1/edit
  def edit
    @course = current_user.courses.find(params[:id])
    @course.sections.build
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = current_user.courses.build(params[:course])

    respond_to do |format|
      if @course.save
        current_user.courses << @course
        Subscription.where(course_id: @course.id, user_id: current_user.id).first.update_attribute(:user_type, 'Teacher')
        session[:course_id] = @course.id
        format.html { redirect_to course_steps_path }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /courses/1
  # PUT /courses/1.json
  def update
    @course = current_user.courses.find_by_slug(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        session[:course_id] = @course.id
        if @course.is_published
          add_activity_stream('COURSE', @course, 'updated')
        end
        format.html { redirect_to course_steps_path }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course = current_user.courses.find_by_slug(params[:id])
    @course.destroy

    respond_to do |format|
      format.html { redirect_to my_courses_courses_url }
    end
  end

  def publish_unpublish
    course = current_user.courses.find_by_id(params[:id])

    if course.present?
      if course.is_published == true || current_user.allowed_to_publish?(course.id)
        if course.togglePublish == true
		      add_activity_stream('COURSE', course, 'published') if course.is_published == true

          render json: { status: 'success', data: course.is_published }
        else
          render json: { status: course.togglePublish[:status], errorCode: course.togglePublish[:error_code], data: course.togglePublish[:error_msg] }
        end
      else
        if current_user.subscription_type == 'free'
          render json: { status: 'error', errorCode: '400', data: "Error! Free user can only publish a maximum of #{ENV['FREE_USER_MAX_FREE_COURSES_COUNT']} courses..." }
        elsif current_user.subscription_type == 'paid' && course.is_paid == false
          render json: { status: 'error', errorCode: '400', data: "Error! Premium user can only publish a maximum of #{ENV['PAID_USER_MAX_FREE_COURSES_COUNT']} free courses..." }
        elsif current_user.subscription_type == 'paid' && course.is_paid == true
          render json: { status: 'error', errorCode: '400', data: "Error! Premium user can only publish a maximum of #{ENV['PAID_USER_MAX_PAID_COURSES_COUNT']} paid courses..." }
        end
      end
    else
      render json: { status: 'error', errorCode: '404', data: 'Course not found!' }
    end
  end

  def rate_course
    if params[:course_id].present?
      course = Course.find_by_id(params[:course_id])

      if params[:rate]
        rating = course.ratings.where(ip_address: request.remote_ip).first_or_initialize
        rating.rate = params[:rate]

        if rating.save
          render json: { status: 'success', data: 'Rating submitted successfully!' }
        else
          render json: { status: 'error', data: 'Sorry! Rating could not be saved, please try again later...' }
        end
      else
        render json: { status: 'error', data: 'Error! We did not receive your rating...' }
      end
    else
      render json: { status: 'error', data: 'Course not found!' }
    end
  end

  def classroom_settings
    @course = Course.find(params[:id])
  end

  def update_classroom_settings
    @course = Course.find(params[:id])
    redirect_to my_courses_courses_path, alert: 'You are not allowed to access this section!' unless current_user.type == 'Teacher' && current_user.courses.include?(@course)
    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to my_courses_courses_path, notice: "Classroom settings updated successfully." }
      else
        format.html { render action: :classroom_settings }
      end
    end
  end

  private

    def authorize_user
      redirect_to my_courses_courses_path, alert: 'You are not allowed to access this section!' unless current_user.type == 'Teacher'
    end

    def check_subscribers
      course = current_user.courses.find(params[:id])

      if course.present?
        if course.has_active_learners?
          redirect_to my_courses_courses_path, alert: 'You are not allowed to modify a course while it has active subscriptions!'
        end
      else
        redirect_to my_courses_courses_path, alert: 'The course you are trying to access, could not found!'
      end
    end
end
