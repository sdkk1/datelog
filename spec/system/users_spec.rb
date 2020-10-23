require 'rails_helper'

RSpec.describe "Users", type: :system do
  let!(:user) { create(:user) }
  let!(:admin_user) { create(:user, :admin) }
  let!(:other_user) { create(:user) }
  let!(:datespot) { create(:datespot, user: user) }

  describe "新規登録ページ" do
    before do
      visit signup_path
    end

    context "ページレイアウト" do
      it "「新規登録」の文字列が存在することを確認" do
        expect(page).to have_content '新規登録'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title('新規登録')
      end
    end

    context "ユーザー登録処理" do
      it "有効なユーザーでユーザー登録を行うとユーザー登録成功のフラッシュが表示されること" do
        fill_in "ユーザー名", with: "Example User"
        fill_in "メールアドレス", with: "user@example.com"
        fill_in "パスワード", with: "password"
        fill_in "パスワード(確認)", with: "password"
        click_button "登録する"
        expect(page).to have_content "デートログへようこそ！"
      end

      it "無効なユーザーでユーザー登録を行うとユーザー登録失敗のフラッシュが表示されること" do
        fill_in "ユーザー名", with: ""
        fill_in "メールアドレス", with: "user@example.com"
        fill_in "パスワード", with: "password"
        fill_in "パスワード(確認)", with: "pass"
        click_button "登録する"
        expect(page).to have_content "ユーザー名を入力してください"
        expect(page).to have_content "パスワード(確認)とパスワードの入力が一致しません"
      end
    end
  end

  describe "ユーザー編集ページ" do
    before do
      login_for_system(user)
      visit edit_user_path(user)
    end

    context "ページレイアウト" do
      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title('ユーザー編集')
      end
    end

    it "有効なプロフィール更新を行うと、更新成功のフラッシュが表示されること" do
      fill_in "ユーザー名", with: "Edit Example User"
      fill_in "メールアドレス", with: "edit-user@example.com"
      fill_in "パスワード", with: "foobar"
      fill_in "パスワード(確認)", with: "foobar"
      click_button "更新する"
      expect(page).to have_content "プロフィールが更新されました！"
      expect(user.reload.name).to eq "Edit Example User"
      expect(user.reload.email).to eq "edit-user@example.com"
    end

    it "無効なプロフィール更新をしようとすると、適切なエラーメッセージが表示されること" do
      fill_in "ユーザー名", with: ""
      fill_in "メールアドレス", with: ""
      click_button "更新する"
      expect(page).to have_content 'ユーザー名を入力してください'
      expect(page).to have_content 'メールアドレスを入力してください'
      expect(page).to have_content 'メールアドレスは不正な値です'
    end

    context "アカウント削除処理", js: true do
      it "正しく削除できること" do
        page.accept_confirm("本当にこのユーザーを削除してもよろしいですか？") do
          click_link "ユーザーを削除する"
        end
        expect(page).to have_content "自分のアカウントを削除しました"
      end
    end
  end

  describe "ユーザー詳細ページ" do
    before do
      login_for_system(user)
      create_list(:datespot, 5, user: user)
      visit user_path(user)
    end

    context "ページレイアウト" do
      it "「ユーザー詳細」の文字列が存在することを確認" do
        expect(page).to have_content 'ユーザー詳細'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title('ユーザー詳細')
      end

      it "ユーザー情報が表示されることを確認" do
        expect(page).to have_content user.name
        expect(page).to have_content user.introduction
      end

      it "ユーザー編集ページへのリンクが表示されていることを確認" do
        expect(page).to have_link 'ユーザー編集', href: edit_user_path(user)
      end

      it "デートスポットの件数が表示されていることを確認" do
        expect(page).to have_content "デートスポット (#{user.datespots.count})"
      end

      it "デートスポットの情報が表示されていることを確認" do
        Datespot.take(5).each do |datespot|
          expect(page).to have_link datespot.name
          expect(page).to have_content datespot.address
          expect(page).to have_content datespot.range_i18n
          expect(page).to have_content datespot.tag_list
          expect(page).to have_link datespot.user.name
        end
      end
    end

    context "ユーザーのフォロー/アンフォロー処理", js: true do
      it "ユーザーのフォロー/アンフォローができること" do
        visit user_path(other_user)
        expect(page).to have_button 'いいねをする'
        click_button 'いいねをする'
        expect(page).to have_button 'いいねをやめる'
        click_button 'いいねをやめる'
        expect(page).to have_button 'いいねをする'
      end
    end

    context "お気に入り登録/解除" do
      it "ユーザー詳細ページから投稿のお気に入り登録/解除ができること" do
        expect(user.favorite?(datespot)).to be_falsey
        user.favorite(datespot)
        expect(user.favorite?(datespot)).to be_truthy
        user.unfavorite(datespot)
        expect(user.favorite?(datespot)).to be_falsey
      end
    end

    context "リスト登録/解除" do
      it "ユーザー詳細ページから投稿のリスト登録/解除ができること" do
        expect(user.list?(datespot)).to be_falsey
        user.list(datespot)
        expect(user.list?(datespot)).to be_truthy
        user.unlist(List.first)
        expect(user.list?(datespot)).to be_falsey
      end
    end
  end

  describe "ユーザー一覧ページ" do
    before do
      create_list(:user, 20)
      visit users_path
    end

    context "管理者ユーザーの場合" do
      it "自分以外のユーザーの削除ボタンが表示されること" do
        login_for_system(admin_user)
        User.paginate(page: 1).each do |u|
          expect(page).to have_link u.name, href: user_path(u)
          expect(page).to have_content "削除" unless u == admin_user
        end
      end
    end

    context "管理者ユーザー以外の場合" do
      it "自分のアカウントのみ削除ボタンが表示されること" do
        login_for_system(user)
        User.paginate(page: 1).each do |u|
          expect(page).to have_link u.name, href: user_path(u)
          if u == user
            expect(page).to have_content "削除"
          end
        end
      end
    end
  end
end
