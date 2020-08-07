require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  let!(:admin_user) { create(:user, :admin) }
  let!(:user) { create(:user) }
  let!(:datespot) { create(:datespot, user: user) }

  describe "トップページ" do
    before do
      create_list(:datespot, 10)
    end

    context "ページレイアウト(共通)" do
      before do
        visit root_path
      end

      it "datelogの文字列が存在することを確認" do
        expect(page).to have_content 'datelog'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title
      end

      it "デートスポットの件数が表示されていることを確認" do
        expect(page).to have_content "デートスポット (#{Datespot.all.count})"
      end

      it "デートスポットのページネーションが表示されていることを確認" do
        expect(page).to have_css "div.pagination"
      end
    end

    context "ページレイアウト(管理者ユーザーの場合)" do
      before do
        login_for_system(admin_user)
        visit root_path
      end

      it "デートスポットの情報が表示されていることを確認(投稿者のリンクあり)" do
        Datespot.take(5).each do |datespot|
          expect(page).to have_link datespot.name
          expect(page).to have_content datespot.area
          expect(page).to have_content datespot.price
          expect(page).to have_content datespot.keyword
          expect(page).to have_link datespot.user.name
        end
      end

      it "全ての投稿に削除ボタンが表示されること" do
        Datespot.take(5).each do |datespot|
          expect(page).to have_link "削除"
        end
      end
    end

    context "投稿削除(管理者ユーザーの場合)", js: true do
      before do
        login_for_system(admin_user)
        visit root_path
      end

      it "投稿を削除後、削除成功のフラッシュが表示されること" do
        page.accept_confirm("本当に削除しますか？") do
          click_on "削除", match: :first
        end
        expect(page).to have_content '投稿が削除されました'
      end
    end

    context "ページレイアウト(管理者ユーザー以外の場合)" do
      before do
        login_for_system(user)
        visit root_path
      end

      it "デートスポットの情報が表示されていることを確認(投稿者のリンクあり)" do
        Datespot.take(5).each do |datespot|
          expect(page).to have_link datespot.name
          expect(page).to have_content datespot.area
          expect(page).to have_content datespot.price
          expect(page).to have_content datespot.keyword
          expect(page).to have_link datespot.user.name
        end
      end

      it "自分の投稿のみ削除ボタンが表示されること" do
        Datespot.take(5).each do |datespot|
          expect(page).to have_link "削除" if datespot == user.datespots
        end
      end
    end

    context "投稿削除(管理者ユーザー以外の場合)", js: true do
      before do
        login_for_system(user)
        visit root_path
      end

      it "自分の投稿を削除後、削除成功のフラッシュが表示されること" do
        if datespot == user.datespots
          page.accept_confirm("本当に削除しますか？") do
            click_on "削除", match: :first
          end
          expect(page).to have_content '投稿が削除されました'
        end
      end
    end

    context "ページレイアウト(ログインしていないユーザーの場合)" do
      before do
        visit root_path
      end

      it "デートスポットの情報が表示されていることを確認(投稿者のリンクなし)" do
        Datespot.take(5).each do |datespot|
          expect(page).to have_link datespot.name
          expect(page).to have_content datespot.area
          expect(page).to have_content datespot.price
          expect(page).to have_content datespot.keyword
          expect(page).to have_content datespot.user.name
        end
      end

      it "削除ボタンが表示されないこと" do
        Datespot.take(5).each do |datespot|
          expect(page).to have_no_link "削除"
        end
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
