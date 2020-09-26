require 'rails_helper'

RSpec.describe "Lists", type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:datespot) { create(:datespot, user: user) }
  let!(:datespot_2) { create(:datespot, user: user) }

  describe "行く予定リストページ" do
    before do
      login_for_system(user)
      visit lists_path
    end

    it "「行く予定リスト」の文字列が存在すること" do
      expect(page).to have_content '行く予定リスト'
    end

    it "正しいタイトルが表示されること" do
      expect(page).to have_title full_title('行く予定リスト')
    end

    it "行く予定リストページが期待通り表示され、リストから削除することもできること" do
      expect(page).not_to have_css ".list-datespot"
      user.list(datespot)
      other_user.list(datespot_2)
      visit lists_path
      expect(page).to have_css ".list-datespot", count: 2
      expect(page).to have_content "この投稿を行く予定リストに追加しました。"
      expect(page).to have_link datespot.name
      expect(page).to have_content datespot.address
      expect(page).to have_content datespot.range_i18n
      expect(page).to have_content datespot.tag_list
      expect(page).to have_link datespot.user.name
      expect(page).to have_content "#{other_user.name}さんがこの投稿に行きたいリクエストをしました。"
      expect(page).to have_link datespot_2.name
      expect(page).to have_content datespot_2.address
      expect(page).to have_content datespot_2.range_i18n
      expect(page).to have_content datespot_2.tag_list
      expect(page).to have_link datespot_2.user.name
      user.unlist(List.first)
      visit lists_path
      expect(page).to have_css ".list-datespot", count: 1
      expect(page).to have_content datespot.name
      find('.unlist').click
      visit lists_path
      expect(page).not_to have_css ".list-datespot"
    end
  end
end
