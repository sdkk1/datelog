require 'rails_helper'

RSpec.describe "Datespots", type: :system do
  let!(:admin_user) { create(:user, :admin) }
  let!(:user) { create(:user) }
  let!(:datespot) { create(:datespot, user: user) }

  describe "投稿一覧ページ" do
    before do
      create_list(:datespot, 10)
    end

    context "ページレイアウト(共通)" do
      before do
        visit datespots_path
      end

      it "「投稿一覧」の文字列が存在することを確認" do
        expect(page).to have_content '投稿一覧'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title('投稿一覧')
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
        visit datespots_path
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
        visit datespots_path
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
        visit datespots_path
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
        visit datespots_path
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
        visit datespots_path
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
        click_button "投稿する"
        expect(page).to have_content "投稿が登録されました！"
      end

      it "無効な情報で投稿するを行うと投稿する失敗のフラッシュが表示されること" do
        fill_in "店名", with: ""
        fill_in "エリア", with: "恵比寿"
        fill_in "価格帯", with: "1万円〜"
        fill_in "キーワード", with: "焼き鳥"
        fill_in "ポイント", with: "シックな店内で落ち着いた雰囲気のお店"
        fill_in "注意点", with: "お酒の種類は少ない"
        click_button "投稿する"
        expect(page).to have_content "店名を入力してください"
      end
    end
  end

  describe "投稿詳細ページ" do
    context "ページレイアウト（共通）" do
      it "正しいタイトルが表示されること" do
        visit datespot_path(datespot)
        expect(page).to have_title full_title("#{datespot.name}")
      end
    end

    context "ページレイアウト(管理者ユーザーの場合)" do
      before do
        login_for_system(admin_user)
        visit datespot_path(datespot)
      end

      it "投稿情報が表示されること(投稿者のリンクあり)" do
        expect(page).to have_content datespot.name
        expect(page).to have_link datespot.user.name
        expect(page).to have_content datespot.area
        expect(page).to have_content datespot.price
        expect(page).to have_content datespot.keyword
        expect(page).to have_content datespot.point
        expect(page).to have_content datespot.caution
      end

      it "削除ボタンが表示されること" do
        expect(page).to have_link "削除"
      end
    end

    context "投稿削除(管理者ユーザーの場合)", js: true do
      before do
        login_for_system(admin_user)
        visit datespot_path(datespot)
      end

      it "投稿を削除後、削除成功のフラッシュが表示されること" do
        page.accept_confirm("本当に削除しますか？") do
          click_on "削除"
        end
        expect(page).to have_content '投稿が削除されました'
      end
    end

    context "ページレイアウト(管理者ユーザー以外の場合)" do
      before do
        login_for_system(user)
        visit datespot_path(datespot)
      end

      it "投稿情報が表示されること(投稿者のリンクあり)" do
        expect(page).to have_content datespot.name
        expect(page).to have_link datespot.user.name
        expect(page).to have_content datespot.area
        expect(page).to have_content datespot.price
        expect(page).to have_content datespot.keyword
        expect(page).to have_content datespot.point
        expect(page).to have_content datespot.caution
      end

      it "自分の投稿のみ削除ボタンが表示されること" do
        expect(page).to have_link "削除" if datespot == user.datespots
      end
    end

    context "投稿削除(管理者ユーザー以外の場合)", js: true do
      before do
        login_for_system(user)
        visit datespot_path(datespot)
      end

      it "自分の投稿を削除後、削除成功のフラッシュが表示されること" do
        if datespot == user.datespots
          page.accept_confirm("本当に削除しますか？") do
            click_on "削除"
          end
          expect(page).to have_content '投稿が削除されました'
        end
      end
    end

    context "ページレイアウト(ログインしていないユーザーの場合)" do
      before do
        visit datespot_path(datespot)
      end

      it "投稿情報が表示されること(投稿者のリンクなし)" do
        expect(page).to have_content datespot.name
        expect(page).to have_content datespot.user.name
        expect(page).to have_content datespot.area
        expect(page).to have_content datespot.price
        expect(page).to have_content datespot.keyword
        expect(page).to have_content datespot.point
        expect(page).to have_content datespot.caution
      end

      it "削除ボタンが表示されないこと" do
        expect(page).to have_no_link "削除"
      end
    end
  end

  describe "投稿編集ページ" do
    before do
      login_for_system(user)
      visit datespot_path(datespot)
      click_link "編集"
    end

    context "ページレイアウト" do
      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('投稿編集')
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

    context "投稿の更新処理" do
      it "有効な更新" do
        fill_in "店名", with: "ももたろう"
        fill_in "エリア", with: "恵比寿"
        fill_in "価格帯", with: "1万円〜"
        fill_in "キーワード", with: "焼き鳥"
        fill_in "ポイント", with: "シックな店内で落ち着いた雰囲気のお店"
        fill_in "注意点", with: "お酒の種類は少ない"
        click_button "更新する"
        expect(page).to have_content "投稿が更新されました！"
        expect(datespot.reload.name).to eq "ももたろう"
        expect(datespot.reload.area).to eq "恵比寿"
        expect(datespot.reload.price).to eq "1万円〜"
        expect(datespot.reload.keyword).to eq "焼き鳥"
        expect(datespot.reload.point).to eq "シックな店内で落ち着いた雰囲気のお店"
        expect(datespot.reload.caution).to eq "お酒の種類は少ない"
      end

      it "無効な更新" do
        fill_in "店名", with: ""
        click_button "更新する"
        expect(page).to have_content '店名を入力してください'
        expect(datespot.reload.name).not_to eq ""
      end
    end

    context "投稿削除", js: true do
      it "投稿を削除後、削除成功のフラッシュが表示されること" do
        page.accept_confirm("本当にこの投稿を削除してもよろしいですか？") do
          click_on "投稿を削除する"
        end
        expect(page).to have_content '投稿が削除されました'
      end
    end
  end
end
