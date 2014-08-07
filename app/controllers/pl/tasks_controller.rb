class Pl::TasksController < ApplicationController
  before_filter :authenticate_user!
  layout 'home_new'

  respond_to :html, :js

  def complete
    @task = Pl::Task.find(params[:id])
    @task.update_attributes completed: true if params["checked"] == "true"
    @task.update_attributes completed: false if params["checked"] == "false"
  end
end