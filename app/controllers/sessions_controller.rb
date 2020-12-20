class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:success] = "ログインしました"
      redirect_back_or datespots_url
    else
      flash.now[:danger] = 'メールアドレスとパスワードの組み合わせが間違っています'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  def new_guest
    user = User.guest
    log_in user
    flash[:success] = "ゲストユーザーとしてログインしました"
    redirect_to datespots_url
  end
end
