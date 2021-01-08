require "rails_helper"

RSpec.describe "提案削除", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:datespot) { create(:datespot, user: user) }

  context "ログインしていて、自分の提案を削除する場合" do
    it "処理が成功し、提案一覧にリダイレクトすること" do
      login_for_request(user)
      expect {
        delete datespot_path(datespot)
      }.to change(Datespot, :count).by(-1)
      redirect_to datespots_url
      follow_redirect!
      expect(response).to render_template('datespots/index')
    end
  end

  context "ログインしていて、他人の提案を削除する場合" do
    it "処理が失敗し、提案一覧にリダイレクトすること" do
      login_for_request(other_user)
      expect {
        delete datespot_path(datespot)
      }.not_to change(Datespot, :count)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to datespots_url
    end
  end

  context "ログインしていない場合" do
    it "ログインページへリダイレクトすること" do
      expect {
        delete datespot_path(datespot)
      }.not_to change(Datespot, :count)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end
end
