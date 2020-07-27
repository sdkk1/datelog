require "rails_helper"

RSpec.describe "ユーザー一覧ページ", type: :request do
  let!(:user) { create(:user) }

  context "認可されたユーザーの場合" do
    it "レスポンスが正常に表示されること(フレンドリーフォワーディング)" do
      get users_path
      login_for_request(user)
      expect(response).to redirect_to users_url
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログインページへリダイレクトすること" do
      get users_path
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end
end
