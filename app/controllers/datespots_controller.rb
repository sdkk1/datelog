class DatespotsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

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

  def edit
    @datespot = Datespot.find(params[:id])
  end

  def update
    @datespot = Datespot.find(params[:id])
    if @datespot.update_attributes(datespot_params)
      flash[:success] = "投稿が更新されました！"
      redirect_to @datespot
    else
      render 'edit'
    end
  end

  private

  def datespot_params
    params.require(:datespot).permit(:name, :area, :price,
                                     :keyword, :point, :caution)
  end

  def correct_user
    @datespot = current_user.datespots.find_by(id: params[:id])
    redirect_to root_url if @datespot.nil?
  end
end
