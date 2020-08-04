require 'rails_helper'

RSpec.describe "Datespots", type: :system do
  describe "投稿一覧ページ" do
    before do
      create_list(:datespot, 10)
      visit datespots_path
    end

    context "ページレイアウト" do
      it "「投稿一覧」の文字列が存在することを確認" do
        expect(page).to have_content '投稿一覧'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title('投稿一覧')
      end

      it "デートスポットの件数が表示されていることを確認" do
        expect(page).to have_content "デートスポット (#{Datespot.all.count})"
      end

      it "デートスポットの情報が表示されていることを確認" do
        Datespot.take(5).each do |datespot|
          expect(page).to have_link datespot.name
          expect(page).to have_content datespot.area
          expect(page).to have_content datespot.price
          expect(page).to have_content datespot.keyword
          expect(page).to have_link datespot.user.name
        end
      end

      it "デートスポットのページネーションが表示されていることを確認" do
        expect(page).to have_css "div.pagination"
      end
    end
  end
end
