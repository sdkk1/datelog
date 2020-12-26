class BrowsingHistoriesController < ApplicationController
  before_action :logged_in_user

  def index
    @histories = current_user.browsing_histories.preload(:datespot, datespot: { images_attachments: :blob }).sort_desc
  end
end
