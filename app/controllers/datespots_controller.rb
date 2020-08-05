class DatespotsController < ApplicationController
  before_action :logged_in_user, only: [:new]

  def new
    @datespot = Datespot.new
  end

  def show
    @datespot = Datespot.find(params[:id])
  end

  def index
    @datespots = Datespot.paginate(page: params[:page], per_page: 5)
  end

  def create
    @datespot = current_user.datespots.build(datespot_params)
    if @datespot.save
      flash[:success] = "投稿が登録されました！"
      redirect_to datespots_url
    else
      render 'datespots/new'
    end
  end

  private

  def datespot_params
    params.require(:datespot).permit(:name, :area, :price,
                                     :keyword, :point, :caution)
  end
end
