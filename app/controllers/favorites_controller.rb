class FavoritesController < ApplicationController
  before_action :logged_in_user

  def index
    @favorites = current_user.favorites.includes(datespot: { images_attachments: :blob }).order('created_at DESC')
    @datespots = current_user.favorite_datespots
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
