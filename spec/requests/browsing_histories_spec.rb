require 'rails_helper'

RSpec.describe "閲覧履歴機能", type: :request do
  let(:user) { create(:user) }
  let(:datespot) { create(:datespot) }

  describe "閲覧履歴一覧ページ" do
    context "ログインしている場合" do
      it "レスポンスが正常に表示されること" do
        login_for_request(user)
        get browsing_histories_path
        expect(response).to have_http_status "200"
        expect(response).to render_template('browsing_histories/index')
      end
    end

    context "ログインしていない場合" do
      it "ログイン画面にリダイレクトすること" do
        get browsing_histories_path
        expect(response).to have_http_status "302"
        expect(response).to redirect_to login_path
      end
    end
  end
end
