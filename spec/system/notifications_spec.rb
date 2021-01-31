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

    context "自分以外のユーザーの提案に対して" do
      it "リスト登録によって通知が作成されること" do
        visit datespot_path(other_datespot)
        find('.list-button__before').click
        logout
        login_for_system(other_user)
        visit notifications_path
        expect(page).to have_content "あなたの提案に#{user.name}さんが行きたい！リクエストをしました"
      end
    end
  end
end
