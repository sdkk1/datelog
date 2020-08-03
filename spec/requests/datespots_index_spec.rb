require "rails_helper"

RSpec.describe "投稿一覧ページ", type: :request do
  it "レスポンスが正常に表示されること" do
    get datespots_path
    expect(response).to render_template('datespots/index')
  end
end
