class ListsController < ApplicationController
  before_action :logged_in_user

  def index
    @lists_all = current_user.lists.preload(datespot: { images_attachments: :blob }).sort_desc
    @lists = Kaminari.paginate_array(@lists_all).page(params[:page]).per(5)
  end

  def my_index
    get_my_lists_ids = List.where(from_user_id: current_user.id).pluck(:datespot_id)
    @datespots_all = Datespot.where(id: get_my_lists_ids).preload(:taggings, :comments, images_attachments: :blob, user: { avatars_attachments: :blob }).sort_desc
    @datespots = Kaminari.paginate_array(@datespots_all).page(params[:page]).per(6)
    @user = current_user

    respond_to do |format|
      format.html
      format.js
    end
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
