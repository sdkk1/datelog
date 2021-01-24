class RoomsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:show]

  def index
    get_followed_user_ids = Relationship.where(followed_id: current_user.id).pluck(:follower_id)
    get_match_user_ids = Relationship.where(followed_id: get_followed_user_ids, follower_id: current_user.id).pluck(:followed_id)
    @match_users_all = User.eager_load(:passive_relationships).where(id: get_match_user_ids).order("relationships.created_at DESC")
    @match_users = Kaminari.paginate_array(@match_users_all).page(params[:page]).per(10)
  end

  def create
    current_user_rooms = Entry.where(user_id: current_user.id).map(&:room)
    room = Entry.where(room: current_user_rooms, user_id: params[:user_id]).map(&:room).first

    if room.blank?
      room = Room.create
      Entry.create(room: room, user_id: current_user.id)
      Entry.create(room: room, user_id: params[:user_id])
    end

    redirect_to action: :show, id: room.id
  end

  def show
    @room = Room.find(params[:id])
    @message_user = @room.entries.where.not(user_id: current_user.id).first.user

    @message = Message.new
    @messages = @room.messages.preload(:user)
  end

  private

  # 正しいユーザーかどうか確認
  def correct_user
    @room = Room.find(params[:id])
    @message_user1 = @room.entries.first.user
    @message_user2 = @room.entries.second.user
    if !current_user?(@message_user1 || @message_user2)
      flash[:error] = "このページへはアクセスできません。"
      redirect_to(datespots_url)
    end
  end
end
