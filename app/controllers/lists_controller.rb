class ListsController < ApplicationController
  before_action :logged_in_user

  def index
    @lists = current_user.lists.includes(datespot: { images_attachments: :blob })
  end

  def create
    @datespot = Datespot.find(params[:datespot_id])
    @user = @datespot.user
    current_user.list(@datespot)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
    if @user != current_user
      @user.notifications.create(datespot_id: @datespot.id, variety: 1, from_user_id: current_user.id)
      @user.update_attribute(:notification, true)
    end
  end

  def destroy
    list = List.find(params[:list_id])
    @datespot = list.datespot
    list.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end
end
