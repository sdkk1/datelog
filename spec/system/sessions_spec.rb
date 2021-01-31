require 'rails_helper'

RSpec.describe "Sessions", type: :system do
  let!(:user) { create(:user) }

  before do
    visit login_path
  end

  describe "ログインページ" do
    context "ページレイアウト" do
      it "「ログイン」の文字列が存在することを確認" do
        expect(page).to have_content 'ログイン'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title('ログイン')
      end

      it "ヘッダーにログインページへのリンクがあることを確認" do
        expect(page).to have_link 'ログイン', href: login_path
      end

      it "ログインフォームのラベルが正しく表示される" do
        expect(page).to have_content 'メールアドレス'
        expect(page).to have_content 'パスワード'
      end

      it "ログインフォームが正しく表示される" do
        expect(page).to have_css 'input#user_email'
        expect(page).to have_css 'input#user_password'
      end

      it "ログインボタンが表示される" do
        expect(page).to have_button 'ログイン'
      end
    end

    context "ログイン処理" do
      it "有効なユーザーでのログイン前後でサイドバーが正しく表示されていることを確認" do
        expect(page).to have_link 'トップ', href: root_url
        expect(page).to have_link '新規登録', href: signup_path
        expect(page).to have_link 'ログイン', href: login_path

        fill_in "user_email", with: user.email
        fill_in "user_password", with: user.password
        click_button "ログイン"

        expect(page).to have_link 'デートを探す', href: datespots_path
        expect(page).to have_link '行きたい！', href: lists_path
        expect(page).to have_link 'ユーザーを探す', href: users_path
        expect(page).to have_link 'いいね！', href: followers_user_path(user)
        expect(page).to have_link 'メッセージ', href: rooms_path
        expect(page).to have_link 'プロフィール', href: user_path(user)
        expect(page).to have_link '通知一覧', href: notifications_path
        expect(page).to have_link 'ログアウト', href: logout_path
      end
    end
  end
end
