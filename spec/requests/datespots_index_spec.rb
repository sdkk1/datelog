require "rails_helper"

RSpec.describe "投稿一覧ページ", type: :request do
  let!(:user) { create(:user) }

  before do
    get new_datespot_path
    login_for_request(user)
  end

  it "レスポンスが正常に表示されること" do
    get datespots_path
    expect(response).to render_template('datespots/index')
  end
end
