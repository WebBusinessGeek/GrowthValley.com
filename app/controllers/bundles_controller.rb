class BundlesController < ApplicationController
	def index
          @bundles = current_user.bundles.page(params[:page])
	end
	def new
	  @courses = current_user.courses.where(:is_published => 'true')
	  @bundle =Bundle.new
           
	end
	def create
          @bundle =current_user.bundles.build(params[:bundle])
          if @bundle.save
	      redirect_to bundles_path
	  else
	     render :new
	  end
	end
	def edit
          @bundle=current_user.bundles.find(params[:id])
          
        end
	def update
          @bundle=current_user.bundles.find(params[:id])
          if @bundle.update_attributes(params[:bundle]) 
               redirect_to bundles_path
          else
               render :edit
          end
	end
end
