class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
    if @user != current_user
      @user.notifications.create(variety: 3, from_user_id: current_user.id)
      @user.update_attribute(:notification, true)
    end
  end
end
