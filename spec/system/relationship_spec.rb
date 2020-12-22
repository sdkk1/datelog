require 'rails_helper'

RSpec.describe "Relationships", type: :system do
  let!(:user) { create(:user) }
  let!(:user2) { create(:user) }

  describe "フォローページ" do
    before do
      create(:relationship, follower_id: user.id, followed_id: user2.id)
      login_for_system(user)
      visit following_user_path(user)
    end

    context "ページレイアウト" do
      it "「いいね！一覧(自分から)」の文字列が存在すること" do
        expect(page).to have_content 'いいね！一覧(自分から)'
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('いいね！一覧(自分から)')
      end

      it "いいね！一覧(自分から)が表示されていること" do
        within find('.user-index__card') do
          user.following.each do |u|
            expect(page).to have_link u.name, href: user_path(u)
          end
        end
      end
    end
  end

  describe "フォロワーページ" do
    before do
      create(:relationship, follower_id: user2.id, followed_id: user.id)
      login_for_system(user)
      visit followers_user_path(user)
    end

    context "ページレイアウト" do
      it "「いいね！一覧(相手から)」の文字列が存在すること" do
        expect(page).to have_content 'いいね！一覧(相手から)'
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('いいね！一覧(相手から)')
      end

      it "いいね！一覧(相手から)が表示されていること" do
        within find('.user-index__card') do
          user.followers.each do |u|
            expect(page).to have_link u.name, href: user_path(u)
          end
        end
      end
    end
  end
end
