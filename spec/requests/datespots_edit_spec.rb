require "rails_helper"

RSpec.describe "投稿編集", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:datespot) { create(:datespot, user: user) }

  context "認可されたユーザーの場合" do
    it "レスポンスが正常に表示されること(フレンドリーフォワーディング)" do
      get edit_datespot_path(datespot)
      login_for_request(user)
      expect(response).to redirect_to edit_datespot_url(datespot)
      patch datespot_path(datespot), params: { datespot: {
        name: "ももたろう",
        address: "東京都渋谷区恵比寿西",
        range: "price_min",
        tag_list: "オシャレ,焼き鳥",
        point: "シックな店内で落ち着いた雰囲気のお店",
        caution: "お酒の種類は少ない",
      } }
      redirect_to datespot
      follow_redirect!
      expect(response).to render_template('datespots/show')
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトすること" do
      get edit_datespot_path(datespot)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path

      patch datespot_path(datespot), params: { datespot: {
        name: "ももたろう",
        address: "東京都渋谷区恵比寿西",
        range: "price_min",
        tag_list: "オシャレ,焼き鳥",
        point: "シックな店内で落ち着いた雰囲気のお店",
        caution: "お酒の種類は少ない",
      } }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end

  context "別アカウントのユーザーの場合" do
    it "ホーム画面にリダイレクトすること" do
      login_for_request(other_user)
      get edit_datespot_path(datespot)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path

      patch datespot_path(datespot), params: { datespot: {
        name: "ももたろう",
        address: "東京都渋谷区恵比寿西",
        range: "price_min",
        tag_list: "オシャレ,焼き鳥",
        point: "シックな店内で落ち着いた雰囲気のお店",
        caution: "お酒の種類は少ない",
      } }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
    end
  end
end
