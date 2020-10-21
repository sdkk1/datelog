class MessagesController < ApplicationController
  before_action :logged_in_user

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.build(message_params)
    @message.user_id = current_user.id
    if @message.save
      render :index
    else
      render :error_messages
    end
  end

  def destroy
    @message = Message.find(params[:id])
    if current_user.id == @message.user_id && @message.destroy
      @room = Room.find(params[:room_id])
      render :index
    end
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :room_id, :content, :picture)
  end
end
