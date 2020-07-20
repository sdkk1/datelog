require 'rails_helper'

RSpec.describe "Users", type: :system do
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
  end
end
