class BundlesController < ApplicationController
	def index
    @current_menu = "bundles"
    @show_top_menu = true

    @bundles = Bundle.active_and_available_bundles.page(params[:page])
	end

	def new
	  @courses = current_user.courses.where(:is_published => 'true')
	  @bundle = current_user.bundles.build
	end

	def create
    @bundle = current_user.bundles.build(params[:bundle])

    if @bundle.save
      redirect_to bundles_path
	  else
      render :new
	  end
	end

	def edit
    @bundle = current_user.bundles.find(params[:id])
  end

	def update
    @bundle = current_user.bundles.find(params[:id])

    if @bundle.update_attributes(params[:bundle]) 
      redirect_to bundles_path
    else
      render :edit
    end
	end

  def show
    render :text => "Bundle details page"
  end

  def my_bundles
    if current_user.type == 'Teacher'
      @bundles = current_user.bundles.page(params[:page])
    else
      @bundles = current_user.bundles.active_bundles.page(params[:page])
    end

    respond_to do |format|
      format.html # index.html.erb
    end
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
