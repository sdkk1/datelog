require 'rails_helper'

RSpec.describe "お気に入り機能", type: :request do
  let(:user) { create(:user) }
  let(:datespot) { create(:datespot) }

  describe "お気に入り処理" do
    context "ログインしている場合" do
      before do
        login_for_request(user)
      end

      it "投稿のお気に入り登録ができること" do
        expect {
          post "/favorites/#{datespot.id}/create"
        }.to change(user.favorites, :count).by(1)
      end

      it "投稿のAjaxによるお気に入り登録ができること" do
        expect {
          post "/favorites/#{datespot.id}/create", xhr: true
        }.to change(user.favorites, :count).by(1)
      end

      it "投稿のお気に入り解除ができること" do
        user.favorite(datespot)
        expect {
          delete "/favorites/#{datespot.id}/destroy"
        }.to change(user.favorites, :count).by(-1)
      end

      it "投稿のAjaxによるお気に入り解除ができること" do
        user.favorite(datespot)
        expect {
          delete "/favorites/#{datespot.id}/destroy", xhr: true
        }.to change(user.favorites, :count).by(-1)
      end
    end

    context "ログインしていない場合" do
      it "お気に入り登録は実行できず、ログインページへリダイレクトすること" do
        expect {
          post "/favorites/#{datespot.id}/create"
        }.not_to change(Favorite, :count)
        expect(response).to redirect_to login_path
      end

      it "お気に入り解除は実行できず、ログインページへリダイレクトすること" do
        expect {
          delete "/favorites/#{datespot.id}/destroy"
        }.not_to change(Favorite, :count)
        expect(response).to redirect_to login_path
      end
    end
  end
end
