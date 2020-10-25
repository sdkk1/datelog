require 'rails_helper'

RSpec.describe "ユーザーのいいね！機能", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  context "ログインしている場合" do
    before do
      login_for_request(user)
    end

    it "ユーザーをいいね！できること" do
      expect {
        post relationships_path, params: { followed_id: other_user.id }
      }.to change(user.following, :count).by(1)
    end

    it "ユーザーのAjaxによるいいね！ができること" do
      expect {
        post relationships_path, xhr: true, params: { followed_id: other_user.id }
      }.to change(user.following, :count).by(1)
    end
  end

  context "ログインしていない場合" do
    it "followingページへ飛ぶとログインページへリダイレクトすること" do
      get following_user_path(user)
      expect(response).to redirect_to login_path
    end

    it "followersページへ飛ぶとログインページへリダイレクトすること" do
      get followers_user_path(user)
      expect(response).to redirect_to login_path
    end

    it "createアクションは実行できず、ログインページへリダイレクトすること" do
      expect {
        post relationships_path
      }.not_to change(Relationship, :count)
      expect(response).to redirect_to login_path
    end
  end
end
