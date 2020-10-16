class MessagesController < ApplicationController
  before_action :logged_in_user

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(message_params)
    else
      flash.now[:danger] = "メッセージの送信に失敗しました"
    end
    redirect_to "/rooms/#{@message.room_id}"
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to "/rooms/#{@message.room_id}"
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :room_id, :content).merge(user_id: current_user.id)
  end
end
