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
      it "有効なユーザーでユーザー登録を行うとユーザー登録が成功する" do
        fill_in "ユーザー名", with: "Example User"
        fill_in "メールアドレス", with: "user@example.com"
        fill_in "パスワード", with: "password"
        fill_in "パスワード(確認)", with: "password"
        click_button "登録する"
      end

      it "無効なユーザーでユーザー登録を行うとユーザー登録失敗のフラッシュが表示されること" do
        fill_in "ユーザー名", with: ""
        fill_in "メールアドレス", with: "user@example.com"
        fill_in "パスワード", with: "password"
        fill_in "パスワード(確認)", with: "pass"
        click_button "登録する"
        expect(page).to have_content "ユーザー名を入力または選択してください"
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
        expect(page).to have_title full_title('編集する')
      end
    end

    it "有効なプロフィール更新を行うと、更新が成功する" do
      choose '男性'
      fill_in "ユーザー名", with: "Edit Example User"
      fill_in "メールアドレス", with: "edit-user@example.com"
      fill_in "パスワード", with: "foobar"
      fill_in "パスワード(確認)", with: "foobar"
      click_button "更新する"
      expect(user.reload.name).to eq "Edit Example User"
      expect(user.reload.email).to eq "edit-user@example.com"
    end

    it "無効なプロフィール更新をしようとすると、適切なエラーメッセージが表示されること" do
      fill_in "ユーザー名", with: ""
      fill_in "メールアドレス", with: ""
      fill_in "パスワード", with: ""
      fill_in "パスワード(確認)", with: ""
      click_button "更新する"
      expect(page).to have_content 'ユーザー名を入力または選択してください'
      expect(page).to have_content 'メールアドレスを入力または選択してください'
      expect(page).to have_content 'メールアドレスは不正な値です'
      expect(page).to have_content 'パスワードを入力または選択してください'
      expect(page).to have_content 'パスワードは6文字以上で入力してください'
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
      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title(user.name)
      end

      it "ユーザー情報が表示されることを確認" do
        expect(page).to have_content user.name
        expect(page).to have_content user.introduction
      end

      it "ユーザー編集ページへのリンクが表示されていることを確認" do
        expect(page).to have_selector '#user-edit'
      end

      it "デートスポットの件数が表示されていることを確認" do
        expect(page).to have_content "提案一覧(#{user.datespots.count}件)"
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

    context "ユーザーをいいね！する" do
      it "ユーザーをいいね！できること" do
        visit user_path(other_user)
        expect(page).to have_button 'いいね！'
        click_button 'いいね！'
        expect(page).to have_button 'いいね！済'
      end
    end

    context "お気に入り登録/解除" do
      it "ユーザー詳細ページから提案のお気に入り登録/解除ができること" do
        expect(user.favorite?(datespot)).to be_falsey
        user.favorite(datespot)
        expect(user.favorite?(datespot)).to be_truthy
        user.unfavorite(datespot)
        expect(user.favorite?(datespot)).to be_falsey
      end
    end

    context "リスト登録/解除" do
      it "ユーザー詳細ページから提案のリスト登録/解除ができること" do
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

    context "アカウント削除処理(管理者ユーザーの場合)", js: true do
      it "アカウントを削除後、削除成功のフラッシュが表示されること" do
        login_for_system(admin_user)
        within first('.user-index__card') do
          page.accept_confirm("本当に削除しますか？") do
            find('#user-delete').click
          end
        end
        expect(page).to have_content 'ユーザーの削除に成功しました'
      end
    end
  end
end
