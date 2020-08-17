class DatespotsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]

  def new
    @datespot = Datespot.new
  end

  def show
    @datespot = Datespot.find(params[:id])
    @comment = Comment.new
    @comments = @datespot.comments
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

  def destroy
    @datespot = Datespot.find(params[:id])
    if current_user.admin? || current_user?(@datespot.user)
      @datespot.destroy
      flash[:success] = "投稿が削除されました"
      redirect_to request.referrer == user_url(@datespot.user) ? user_url(@datespot.user) : datespots_url
    else
      flash[:danger] = "他人の投稿は削除できません"
      redirect_to datespots_url
    end
  end

  private

  def datespot_params
    params.require(:datespot).permit(:name, :area, :price, :keyword,
                                     :point, :caution, :picture, :remove_picture)
  end

  def correct_user
    @datespot = current_user.datespots.find_by(id: params[:id])
    redirect_to root_url if @datespot.nil?
  end
end
