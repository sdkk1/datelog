require 'rails_helper'

RSpec.describe "BrowsingHistories", type: :system do
  let!(:user) { create(:user) }

  describe "閲覧履歴一覧ページ" do
    before do
      login_for_system(user)
      visit browsing_histories_path
    end

    it "「閲覧履歴一覧」の文字列が存在すること" do
      expect(page).to have_content '閲覧履歴一覧'
    end

    it "正しいタイトルが表示されること" do
      expect(page).to have_title full_title('閲覧履歴一覧')
    end
  end
end
