class StaticPagesController < ApplicationController
  def home
    @datespots = Datespot.paginate(page: params[:page], per_page: 5)
  end
end
