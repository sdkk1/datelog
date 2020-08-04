class DatespotsController < ApplicationController
  before_action :logged_in_user, only: [:new]

  def new
    @datespot = Datespot.new
  end

  def index
    @datespots = Datespot.paginate(page: params[:page], per_page: 5)
  end
end
