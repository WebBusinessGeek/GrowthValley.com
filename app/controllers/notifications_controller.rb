class NotificationsController < ApplicationController
  before_filter :find_notification, only: :toggle
  respond_to :html, :js
  def toggle
    if @notification.read?
      @notification.update_attribute(:read, false)
    else
      @notification.update_attribute(:read, true)
    end
    respond_with @notification
  end
  private
    def find_notification
    	@notification = Notification.find(params[:id])
    end
end