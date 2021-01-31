class NotificationsController < ApplicationController
  before_action :logged_in_user

  def index
    @notifications_all = current_user.notifications.preload(datespot: { images_attachments: :blob }).sort_desc
    @notifications = Kaminari.paginate_array(@notifications_all).page(params[:page]).per(10)
    current_user.update_attribute(:notification, false)
  end

  def destroy
    @notifications = current_user.notifications.destroy_all
    redirect_to notifications_path
  end
end
