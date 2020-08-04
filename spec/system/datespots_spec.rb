require 'rails_helper'

RSpec.describe "Datespots", type: :system do
  let!(:user) { create(:user) }

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

  describe "投稿ページ" do
    before do
      login_for_system(user)
      visit new_datespot_path
    end

    context "ページレイアウト" do
      it "「投稿する」の文字列が存在すること" do
        expect(page).to have_content '投稿する'
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('投稿')
      end

      it "入力部分に適切なラベルが表示されること" do
        expect(page).to have_content '店名'
        expect(page).to have_content 'エリア'
        expect(page).to have_content '価格帯'
        expect(page).to have_content 'キーワード'
        expect(page).to have_content 'ポイント'
        expect(page).to have_content '注意点'
      end
    end

    context "投稿する処理" do
      it "有効な情報で投稿するを行うと投稿する成功のフラッシュが表示されること" do
        fill_in "店名", with: "ももたろう"
        fill_in "エリア", with: "恵比寿"
        fill_in "価格帯", with: "1万円〜"
        fill_in "キーワード", with: "焼き鳥"
        fill_in "ポイント", with: "シックな店内で落ち着いた雰囲気のお店"
        fill_in "注意点", with: "お酒の種類は少ない"
        click_button "登録する"
        expect(page).to have_content "投稿が登録されました！"
      end

      it "無効な情報で投稿するを行うと投稿する失敗のフラッシュが表示されること" do
        fill_in "店名", with: ""
        fill_in "エリア", with: "恵比寿"
        fill_in "価格帯", with: "1万円〜"
        fill_in "キーワード", with: "焼き鳥"
        fill_in "ポイント", with: "シックな店内で落ち着いた雰囲気のお店"
        fill_in "注意点", with: "お酒の種類は少ない"
        click_button "登録する"
        expect(page).to have_content "店名を入力してください"
      end
    end
  end
end
