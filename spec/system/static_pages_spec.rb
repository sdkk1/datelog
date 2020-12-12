require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  let!(:admin_user) { create(:user, :admin) }
  let!(:user) { create(:user) }
  let!(:datespot) { create(:datespot, user: user) }

  describe "トップページ" do
    before do
      create_list(:datespot, 5)
    end

    context "ページレイアウト(共通)" do
      before do
        visit root_path
      end

      it "date-matchの文字列が存在することを確認" do
        expect(page).to have_content 'date-match'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title
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
          expect(page).to have_content datespot.address
          expect(page).to have_content datespot.range_i18n
          expect(page).to have_content datespot.tag_list
          expect(page).to have_link datespot.user.name
        end
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
          expect(page).to have_content datespot.address
          expect(page).to have_content datespot.range_i18n
          expect(page).to have_content datespot.tag_list
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
          expect(page).to have_content datespot.address
          expect(page).to have_content datespot.range_i18n
          expect(page).to have_content datespot.tag_list
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
end
