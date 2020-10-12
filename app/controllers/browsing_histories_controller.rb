class BrowsingHistoriesController < ApplicationController
  before_action :logged_in_user

  def index
    @histories = current_user.browsing_histories.includes(:datespot, datespot: { images_attachments: :blob }).order('created_at DESC')
  end
end