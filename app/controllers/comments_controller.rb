class CommentsController < ApplicationController
  before_action :logged_in_user

  def create
    @datespot = Datespot.find(params[:datespot_id])
    @comment = @datespot.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      render :index
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      render :index
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :datespot_id, :user_id)
  end
end
