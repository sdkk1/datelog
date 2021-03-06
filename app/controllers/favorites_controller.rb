class FavoritesController < ApplicationController
  before_action :logged_in_user

  def index
    @datespots_all = current_user.favorite_datespots.preload(:taggings, :comments, images_attachments: :blob, user: { avatars_attachments: :blob }).sort_desc
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
    current_user.favorite(@datespot)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  def destroy
    @datespot = Datespot.find(params[:datespot_id])
    current_user.favorites.find_by(datespot_id: @datespot.id).destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end
end
