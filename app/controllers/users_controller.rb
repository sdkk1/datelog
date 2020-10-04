class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @datespots = @user.datespots.includes(:taggings, :comments, images_attachments: :blob, user: { avatars_attachments: :blob }).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
  end

  def index
    if params[:q].present?
      @search = User.ransack(params[:q])
      @users = @search.result.with_attached_avatars.paginate(page: params[:page])
    else
      params[:q] = { sorts: 'updated_at desc' }
      @search = User.ransack(params[:q])
      @users = @search.result.with_attached_avatars.paginate(page: params[:page])
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "デートログへようこそ！"
      redirect_to datespots_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:user][:avatar_ids]
      params[:user][:avatar_ids].each do |avatar_id|
        avatar = @user.avatars.find(avatar_id)
        avatar.purge
      end
    end
    if @user.update_attributes(user_params)
      flash[:success] = "プロフィールが更新されました！"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if current_user.admin?
      @user.destroy
      flash[:success] = "ユーザーの削除に成功しました"
      redirect_to users_url
    elsif current_user?(@user)
      @user.destroy
      flash[:success] = "自分のアカウントを削除しました"
      redirect_to root_url
    else
      flash[:danger] = "他人のアカウントは削除できません"
      redirect_to root_url
    end
  end

  def following
    @title = "フォロー"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,
                                 :prefecture_code, :age, :sex, :introduction, avatars: [])
  end

  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    if !current_user?(@user)
      flash[:danger] = "このページへはアクセスできません"
      redirect_to(root_url)
    end
  end
end
