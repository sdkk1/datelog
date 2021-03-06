require "rails_helper"

RSpec.describe "提案", type: :request do
  let!(:user) { create(:user) }
  let!(:datespot) { create(:datespot, user: user) }

  context "ログインしているユーザーの場合" do
    before do
      get new_datespot_path
      login_for_request(user)
    end

    context "フレンドリーフォワーディング" do
      it "レスポンスが正常に表示されること" do
        expect(response).to redirect_to new_datespot_url
      end
    end

    it "有効な提案で登録できること" do
      expect {
        post datespots_path, params: { datespot: {
          name: "ももたろう",
          prefecture_code: 13,
          address: "東京都渋谷区恵比寿西",
          range: "price_min",
          tag_list: "オシャレ,焼き鳥",
          invitation: "一緒にお食事しませんか？",
          plan: "オシャレなお店でお食事をしながら、会話を楽しむ。",
        } }
      }.to change(Datespot, :count).by(1)
      follow_redirect!
      expect(response).to render_template('datespots/index')
    end

    it "無効な提案では登録できないこと" do
      expect {
        post datespots_path, params: { datespot: {
          name: "",
          address: "東京都渋谷区恵比寿西",
          range: "price_min",
          tag_list: "オシャレ,焼き鳥",
          invitation: "一緒にお食事しませんか？",
          plan: "オシャレなお店でお食事をしながら、会話を楽しむ。",
        } }
      }.not_to change(Datespot, :count)
      expect(response).to render_template('datespots/new')
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトすること" do
      get new_datespot_path
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end
end
