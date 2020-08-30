class StaticPagesController < ApplicationController
  def home
    @datespots = Datespot.paginate(page: params[:page], per_page: 5)
    if params[:tag_name]
      @datespots = Datespot.tagged_with("#{params[:tag_name]}").paginate(page: params[:page], per_page: 5)
    end
  end
end
