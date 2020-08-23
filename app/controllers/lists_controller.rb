class ListsController < ApplicationController
  before_action :logged_in_user

  def index
    @lists = current_user.lists
  end

  def create
    @datespot = Datespot.find(params[:datespot_id])
    @user = @datespot.user
    current_user.list(@datespot)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
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
