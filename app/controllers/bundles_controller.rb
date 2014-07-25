class BundlesController < ApplicationController
  before_filter :authenticate_user!
	def index
    @current_menu = "bundles"
    #@show_top_menu = true

    @bundles = Bundle.active_and_available_bundles.page(params[:page])
    render layout: 'home_new'
	end

	def new
	  @courses = current_user.courses.where(:is_published => 'true')
	  @bundle = current_user.bundles.build
	end

	def create
    @bundle = current_user.bundles.build(params[:bundle])

    if @bundle.save
      current_user.bundles.push(@bundle)

      redirect_to my_bundles_bundles_path
	  else
      render :new
      render layout: 'home_new'
	  end

	end

	def edit
    @bundle = current_user.bundles.find(params[:id])
  end

	def update
    @bundle = current_user.bundles.find(params[:id])

    if @bundle.update_attributes(params[:bundle]) 
      redirect_to my_bundles_bundles_path
    else
      render :edit
    end
	end

  def destroy
    bundle = current_user.bundles.find(params[:id])
    bundle.destroy

    redirect_to my_bundles_bundles_path
  end

  def show
    @bundle = Bundle.find(params[:id])
    render layout: 'home_new'
  end

  def my_bundles
    @courses = current_user.courses.where(:is_published => 'true')
    @bundle = current_user.bundles.build
    if current_user.type == 'Teacher'
      @bundles = current_user.bundles.page(params[:page])
    else
      @bundles = current_user.bundles.active_bundles.page(params[:page])
    end
    render layout: 'home_new'
  end

  def make_active
    if params[:id].present?
      @bundle = Bundle.find_by_id(params[:id])
      @bundle.activate
    else
      render json: { status: 'error', errorCode: '404', data: 'Bundle not found!' }
    end
  end

  def toggle_available
    if params[:id].present?
      @bundle = Bundle.find_by_id(params[:id])
      @bundle.update_attributes(:available => !@bundle.available)
    else
      render json: { status: 'error', errorCode: '404', data: 'Bundle not found!' }
    end
  end
end
