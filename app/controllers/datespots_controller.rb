class DatespotsController < ApplicationController
  def index
    @datespots = Datespot.paginate(page: params[:page], per_page: 5)
  end
end
