class CommentsController < ApplicationController
  before_action :logged_in_user

  def create
    @datespot = Datespot.find(params[:datespot_id])
    @user = @datespot.user
    @comment = @datespot.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      render :index
    else
      render :error_messages
    end
    if @user != current_user
      @user.notifications.create(datespot_id: @datespot.id, variety: 2,
                                 from_user_id: current_user.id,
                                 content: @comment.content)
      @user.update_attribute(:notification, true)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if current_user.id == @comment.user_id && @comment.destroy
      render :index
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :datespot_id, :user_id, :rate, :picture)
  end
end
