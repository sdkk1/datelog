require 'rails_helper'

RSpec.describe "Favorites", type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:datespot) { create(:datespot, user: user) }
  let!(:other_datespot) { create(:datespot, user: other_user) }

  describe "お気に入り一覧ページ" do
    before do
      login_for_system(user)
      visit favorites_path
    end

    it "「お気に入り一覧」の文字列が存在すること" do
      expect(page).to have_content 'お気に入り一覧'
    end

    it "正しいタイトルが表示されること" do
      expect(page).to have_title full_title('お気に入り一覧')
    end

    it "お気に入り一覧ページが期待通り表示されること" do
      expect(page).not_to have_css ".favorite-datespot"
      user.favorite(datespot)
      user.favorite(other_datespot)
      visit favorites_path
      expect(page).to have_css ".favorite-datespot", count: 2
      expect(page).to have_link datespot.name
      expect(page).to have_content datespot.area
      expect(page).to have_content datespot.price
      expect(page).to have_content datespot.keyword
      expect(page).to have_link datespot.user.name
      expect(page).to have_content other_datespot.name
      expect(page).to have_content other_datespot.area
      expect(page).to have_content other_datespot.price
      expect(page).to have_content other_datespot.keyword
      expect(page).to have_link other_datespot.user.name
      user.unfavorite(other_datespot)
      visit favorites_path
      expect(page).to have_css ".favorite-datespot", count: 1
      expect(page).to have_link datespot.name
    end
  end
end
