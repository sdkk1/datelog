require "rails_helper"

RSpec.describe "Notifications", type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:datespot) { create(:datespot, user: user) }
  let!(:other_datespot) { create(:datespot, user: other_user) }

  context "通知生成" do
    before do
      login_for_system(user)
    end

    context "自分以外のユーザーの投稿に対して" do
      it "お気に入り登録によって通知が作成されること" do
        visit datespot_path(other_datespot)
        find('.like').click
        visit datespot_path(other_datespot)
        expect(page).to have_css 'li.no_notification'
        logout
        login_for_system(other_user)
        expect(page).to have_css 'li.new_notification'
        visit notifications_path
        expect(page).to have_css 'li.no_notification'
        expect(page).to have_content "あなたの投稿が#{user.name}さんにお気に入り登録されました。"
        expect(page).to have_content other_datespot.name
      end
    end

    context "自分の投稿に対して" do
      before do
        visit datespot_path(datespot)
      end

      it "お気に入り登録によって通知が作成されないこと" do
        find('.like').click
        visit datespot_path(datespot)
        expect(page).to have_css 'li.no_notification'
        visit notifications_path
        expect(page).not_to have_content 'お気に入りに登録されました。'
        expect(page).not_to have_content datespot.name
      end
    end
  end
end
