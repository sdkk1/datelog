class RoomsController < ApplicationController
  before_action :logged_in_user

  def index
    get_followed_user_ids = Relationship.where(followed_id: current_user.id).pluck(:follower_id)
    get_match_user_ids = Relationship.where(followed_id: get_followed_user_ids, follower_id: current_user.id).pluck(:followed_id)
    @match_users = User.eager_load(:passive_relationships).where(id: get_match_user_ids).order("relationships.created_at DESC").paginate(page: params[:page])
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
end
