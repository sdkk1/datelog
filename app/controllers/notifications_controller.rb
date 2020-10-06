class NotificationsController < ApplicationController
  before_action :logged_in_user

  def index
    @notifications = current_user.notifications.includes(datespot: { images_attachments: :blob }).order('created_at DESC')
    current_user.update_attribute(:notification, false)
  end

  def destroy
    @notifications = current_user.notifications.destroy_all
    redirect_to notifications_path
  end
end
