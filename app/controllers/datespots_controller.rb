class DatespotsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]

  def new
    @datespot = Datespot.new
  end

  def show
    @datespot = Datespot.find(params[:id])
    impressionist(@datespot, "", :unique => [:impressionable_id, :user_id]) if logged_in?

    @comment = Comment.new
    @comments = @datespot.comments.includes(:user)

    if logged_in?
      new_history = @datespot.browsing_histories.new
      new_history.user_id = current_user.id
      if current_user.browsing_histories.exists?(datespot_id: "#{params[:id]}")
        old_history = current_user.browsing_histories.find_by(datespot_id: "#{params[:id]}")
        old_history.destroy
      end
      new_history.save

      histories_stock_limit = 5
      histories = current_user.browsing_histories.all
      if histories.count > histories_stock_limit
        histories[0].destroy
      end
    end
  end

  def index
    if params[:q].present?
      @search = Datespot.ransack(params[:q])
      @datespots = @search.result.with_attached_images.includes(:user, :taggings, :comments).paginate(page: params[:page], per_page: 10)
      if params[:tag_name]
        @datespots = @search.result.tagged_with("#{params[:tag_name]}").with_attached_images.includes(:user, :taggings).paginate(page: params[:page], per_page: 10)
      end
    else
      params[:q] = { sorts: 'updated_at desc' }
      @search = Datespot.ransack(params[:q])
      @datespots = @search.result.with_attached_images.includes(:user, :taggings, :comments).paginate(page: params[:page], per_page: 10)
      if params[:tag_name]
        @datespots = @search.result.tagged_with("#{params[:tag_name]}").with_attached_images.includes(:user, :taggings).paginate(page: params[:page], per_page: 10)
      end
    end
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
    if params[:datespot][:image_ids]
      params[:datespot][:image_ids].each do |image_id|
        image = @datespot.images.find(image_id)
        image.purge
      end
    end
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
    params.require(:datespot).permit(:name, :address, :range, :point, :caution,
                                     :tag_list, images: [])
  end

  def correct_user
    @datespot = current_user.datespots.find_by(id: params[:id])
    redirect_to root_url if @datespot.nil?
  end
end
