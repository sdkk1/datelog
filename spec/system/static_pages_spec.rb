require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  describe "HomePage" do
    before do
      create_list(:datespot, 10)
      visit root_path
    end

    context "ページレイアウト" do
      it "datelogの文字列が存在することを確認" do
        expect(page).to have_content 'datelog'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title
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

  describe "AboutPage" do
    before do
      visit about_path
    end

    it "デートログとは？の文字列が存在することを確認" do
      expect(page).to have_content 'デートログとは？'
    end

    it "正しいタイトルが表示されることを確認" do
      expect(page).to have_title full_title('デートログとは？')
    end
  end

  describe "TermsPage" do
    before do
      visit use_of_terms_path
    end

    it "利用規約の文字列が存在することを確認" do
      expect(page).to have_content '利用規約'
    end

    it "正しいタイトルが表示されることを確認" do
      expect(page).to have_title full_title('利用規約')
    end
  end
end
