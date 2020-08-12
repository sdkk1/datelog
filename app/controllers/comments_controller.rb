class CommentsController < ApplicationController
  before_action :logged_in_user

  def create
    @datespot = Datespot.find(params[:datespot_id])
    @user = @datespot.user
    @comment = @datespot.comments.build(user_id: current_user.id, content: params[:comment][:content])
    if !@datespot.nil? && @comment.save
      flash[:success] = "コメントを追加しました！"
    else
      flash[:danger] = "空のコメントは投稿できません。"
    end
    redirect_to request.referrer || root_url
  end

  def destroy
    @comment = Comment.find(params[:id])
    @datespot = @comment.datespot
    if current_user.id == @comment.user_id
      @comment.destroy
      flash[:success] = "コメントを削除しました"
    end
    redirect_to datespot_url(@datespot)
  end
end
