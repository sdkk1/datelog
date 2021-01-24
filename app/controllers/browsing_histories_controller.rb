class BrowsingHistoriesController < ApplicationController
  before_action :logged_in_user

  def index
    @datespots_all = current_user.browsing_histories.preload(:datespot, datespot: { images_attachments: :blob }).sort_desc
    @datespots = Kaminari.paginate_array(@datespots_all).page(params[:page]).per(6)

    respond_to do |format|
      format.html
      format.js
    end
  end
end
