require "rails_helper"

RSpec.describe "ユーザー詳細ページ", type: :request do
  let!(:user) { create(:user) }

  describe "ユーザー詳細ページ" do
    context "ログインしている場合" do
      it "レスポンスが正常に表示されること" do
        login_for_request(user)
        get user_path(user)
        expect(response).to render_template('users/show')
      end
    end

    context "ログインしていない場合" do
      it "ログイン画面にリダイレクトすること" do
        get user_path(user)
        expect(response).to have_http_status "302"
        expect(response).to redirect_to login_path
      end
    end
  end
end
