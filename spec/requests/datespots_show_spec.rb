require "rails_helper"

RSpec.describe "提案詳細ページ", type: :request do
  let!(:datespot) { create(:datespot) }

  it "レスポンスが正常に表示されること" do
    get datespot_path(datespot)
    expect(response).to have_http_status "200"
    expect(response).to render_template('datespots/show')
  end
end
