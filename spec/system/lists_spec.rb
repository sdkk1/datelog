require 'rails_helper'

RSpec.describe "Lists", type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:datespot) { create(:datespot, user: user) }
  let!(:datespot_2) { create(:datespot, user: user) }

  describe "行きたい！一覧ページ" do
    before do
      login_for_system(other_user)
      visit lists_path
    end

    it "「行きたい！一覧」の文字列が存在すること" do
      expect(page).to have_content '行きたい！一覧'
    end

    it "正しいタイトルが表示されること" do
      expect(page).to have_title full_title('行きたい！一覧')
    end

    it "行きたい！一覧ページが期待通り表示されること" do
      expect(page).not_to have_css ".list-index"
      other_user.list(datespot)
      other_user.list(datespot_2)
      login_for_system(user)
      visit lists_path
      expect(page).to have_css ".list-index", count: 2
      expect(page).to have_content "#{other_user.name}さんがこの提案に行きたい！リクエストをしました"
      expect(page).to have_link datespot.name
      expect(page).to have_content datespot.address
      expect(page).to have_content datespot.range_i18n
      expect(page).to have_content datespot.tag_list
      expect(page).to have_link datespot.user.name
      expect(page).to have_link datespot_2.name
      expect(page).to have_content datespot_2.address
      expect(page).to have_content datespot_2.range_i18n
      expect(page).to have_content datespot_2.tag_list
      expect(page).to have_link datespot_2.user.name
      login_for_system(other_user)
      other_user.unlist(List.last)
      login_for_system(user)
      visit lists_path
      expect(page).to have_css ".list-index", count: 1
      expect(page).to have_content datespot.name
    end
  end
end
