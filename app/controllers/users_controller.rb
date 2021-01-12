class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :check_guest, only: [:update, :destroy]
  impressionist :actions => [:show], :unique => [:impressionable_id, :user_id]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @datespots = @user.datespots.preload(:taggings, :comments, images_attachments: :blob, user: { avatars_attachments: :blob }).paginate(page: params[:page], per_page: 9).sort_desc
  end

  def index
    if params[:q].present?
      @search = User.ransack(params[:q])
      @users = @search.result.with_attached_avatars.paginate(page: params[:page], per_page: 9)
    else
      params[:q] = { sorts: 'updated_at desc' }
      @search = User.ransack(params[:q])
      @users = @search.result.with_attached_avatars.paginate(page: params[:page], per_page: 9)
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "date-matchへようこそ！"
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
      flash[:success] = "ユーザーの削除に成功しました！"
      redirect_to users_url
    elsif current_user?(@user)
      @user.destroy
      flash[:success] = "自分のアカウントを削除しました！"
      redirect_to root_url
    else
      flash[:error] = "他人のアカウントは削除できません。"
      redirect_to root_url
    end
  end

  def following
    @title = "いいね！一覧(自分から)"
    @users_count = "いいね！した人"
    @user = User.find(params[:id])

    get_follower_user_ids = Relationship.where(follower_id: @user.id).pluck(:followed_id)
    get_match_user_ids = Relationship.where(followed_id: @user.id, follower_id: get_follower_user_ids).pluck(:follower_id)
    @following = User.eager_load(:passive_relationships).where(id: get_follower_user_ids).order("relationships.created_at DESC")
    @match_users = User.eager_load(:active_relationships).where(id: get_match_user_ids).order("relationships.created_at DESC")
    @users = @following - @match_users

    render 'show_follow'
  end

  def followers
    @title = "いいね！一覧(相手から)"
    @users_count = "いいね！された人"
    @user = User.find(params[:id])

    get_followed_user_ids = Relationship.where(followed_id: @user.id).pluck(:follower_id)
    get_match_user_ids = Relationship.where(followed_id: get_followed_user_ids, follower_id: @user.id).pluck(:followed_id)
    @followers = User.eager_load(:active_relationships).where(id: get_followed_user_ids).order("relationships.created_at DESC")
    @match_users = User.eager_load(:passive_relationships).where(id: get_match_user_ids).order("relationships.created_at DESC")
    @users = @followers - @match_users

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
      flash[:error] = "このページへはアクセスできません。"
      redirect_to(datespots_url)
    end
  end

  # ゲストユーザーの変更・削除を制限
  def check_guest
    user = User.find(params[:id])
    if user.email.downcase == 'guest@example.com'
      redirect_to datespots_url
      flash[:error] = 'ゲストユーザーの変更・削除はできません。'
    end
  end
end
