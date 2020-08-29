require 'rails_helper'

RSpec.describe Datespot, type: :model do
  let!(:datespot_one_month_ago) { create(:datespot, :one_month_ago) }
  let!(:datespot_one_week_ago) { create(:datespot, :one_week_ago) }
  let!(:datespot_yesterday) { create(:datespot, :yesterday) }
  let!(:datespot) { create(:datespot) }

  context "バリデーション" do
    it "有効な状態であること" do
      expect(datespot).to be_valid
    end

    it "店名がなければ無効な状態であること" do
      datespot = build(:datespot, name: nil)
      datespot.valid?
      expect(datespot.errors[:name]).to include("を入力してください")
    end

    it "店名が50文字以内であること" do
      datespot = build(:datespot, name: "あ" * 51)
      datespot.valid?
      expect(datespot.errors[:name]).to include("は50文字以内で入力してください")
    end

    it "エリアがなければ無効な状態であること" do
      datespot = build(:datespot, place: nil)
      datespot.valid?
      expect(datespot.errors[:place]).to include("を入力してください")
    end

    it "価格帯がなければ無効な状態であること" do
      datespot = build(:datespot, range: nil)
      datespot.valid?
      expect(datespot.errors[:range]).to include("を入力してください")
    end

    it "キーワードがなければ無効な状態であること" do
      datespot = build(:datespot, keyword: nil)
      datespot.valid?
      expect(datespot.errors[:keyword]).to include("を入力してください")
    end

    it "キーワードが50文字以内であること" do
      datespot = build(:datespot, keyword: "あ" * 51)
      datespot.valid?
      expect(datespot.errors[:keyword]).to include("は50文字以内で入力してください")
    end

    it "ポイントが255文字以内であること" do
      datespot = build(:datespot, point: "あ" * 256)
      datespot.valid?
      expect(datespot.errors[:point]).to include("は255文字以内で入力してください")
    end

    it "注意点が255文字以内であること" do
      datespot = build(:datespot, caution: "あ" * 256)
      datespot.valid?
      expect(datespot.errors[:caution]).to include("は255文字以内で入力してください")
    end

    it "ユーザーIDがなければ無効な状態であること" do
      datespot = build(:datespot, user_id: nil)
      datespot.valid?
      expect(datespot.errors[:user_id]).to include("を入力してください")
    end
  end

  context "並び順" do
    it "最も最近の投稿が最初の投稿になっていること" do
      expect(datespot).to eq Datespot.first
    end
  end
end
