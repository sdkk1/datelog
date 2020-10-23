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
      it "「フォロー」の文字列が存在すること" do
        expect(page).to have_content 'フォロー'
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('フォロー')
      end

      it "ユーザー情報が表示されていること" do
        expect(page).to have_content user.name
        expect(page).to have_link "プロフィール", href: user_path(user)
        expect(page).to have_content "【投稿数】 #{user.datespots_count} 件"
        expect(page).to have_link "#{user.following.count}人にいいねをしました", href: following_user_path(user)
        expect(page).to have_link "#{user.followers.count}人にいいねをされました", href: followers_user_path(user)
      end

      it "フォロー中のユーザーが表示されていること" do
        within find('.users') do
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
      it "「フォロワー」の文字列が存在すること" do
        expect(page).to have_content 'フォロワー'
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('フォロワー')
      end

      it "ユーザー情報が表示されていること" do
        expect(page).to have_content user.name
        expect(page).to have_link "プロフィール", href: user_path(user)
        expect(page).to have_content "【投稿数】 #{user.datespots_count} 件"
        expect(page).to have_link "#{user.following.count}人にいいねをしました", href: following_user_path(user)
        expect(page).to have_link "#{user.followers.count}人にいいねをされました", href: followers_user_path(user)
      end

      it "フォロワーが表示されていること" do
        within find('.users') do
          user.followers.each do |u|
            expect(page).to have_link u.name, href: user_path(u)
          end
        end
      end
    end
  end
end
