class MessagesController < ApplicationController
  before_action :logged_in_user

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.build(message_params)
    @message.user_id = current_user.id
    if @message.save
      render :index
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to "/rooms/#{@message.room_id}"
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :room_id, :content)
  end
end
