class BrowsingHistoriesController < ApplicationController
  before_action :logged_in_user

  def index
    @datespots = current_user.browsing_histories.preload(:datespot, datespot: { images_attachments: :blob }).paginate(page: params[:page], per_page: 6).sort_desc
  end
end
