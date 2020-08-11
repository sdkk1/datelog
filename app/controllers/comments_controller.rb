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
  end
end
