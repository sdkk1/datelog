# require "rails_helper"

# RSpec.describe "Notifications", type: :system do
#   let!(:user) { create(:user) }
#   let!(:other_user) { create(:user) }
#   let!(:datespot) { create(:datespot, user: user) }
#   let!(:other_datespot) { create(:datespot, user: other_user) }

#   context "通知生成" do
#     before do
#       login_for_system(user)
#     end

#     context "自分以外のユーザーの提案に対して" do
#       it "リスト登録によって通知が作成されること" do
#         visit datespot_path(other_datespot)
#         find('.list').click
#         visit datespot_path(other_datespot)
#         expect(page).to have_css 'li.no_notification'
#         logout
#         login_for_system(other_user)
#         expect(page).to have_css 'li.new_notification'
#         visit notifications_path
#         expect(page).to have_css 'li.no_notification'
#         expect(page).to have_content "あなたの提案が#{user.name}さんから行きたいリクエストされました。"
#         expect(page).to have_content other_datespot.name
#       end
#     end

#     context "自分の提案に対して" do
#       it "リスト登録によって通知が作成されないこと" do
#         visit datespot_path(datespot)
#         find('.list').click
#         visit datespot_path(datespot)
#         expect(page).to have_css 'li.no_notification'
#         visit notifications_path
#         expect(page).not_to have_content datespot.name
#       end
#     end
#   end
# end
