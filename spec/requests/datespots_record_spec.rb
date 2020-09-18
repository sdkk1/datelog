require "rails_helper"

RSpec.describe "投稿", type: :request do
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

    it "有効な投稿で登録できること" do
      expect {
        post datespots_path, params: { datespot: {
          name: "ももたろう",
          place: "Ginza",
          range: "price_min",
          tag_list: "オシャレ,焼き鳥",
          point: "シックな店内で落ち着いた雰囲気のお店",
          caution: "お酒の種類は少ない",
        } }
      }.to change(Datespot, :count).by(1)
      follow_redirect!
      expect(response).to render_template('datespots/index')
    end

    it "無効な投稿では登録できないこと" do
      expect {
        post datespots_path, params: { datespot: {
          name: "",
          place: "Ginza",
          range: "price_min",
          tag_list: "オシャレ,焼き鳥",
          point: "シックな店内で落ち着いた雰囲気のお店",
          caution: "お酒の種類は少ない",
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
