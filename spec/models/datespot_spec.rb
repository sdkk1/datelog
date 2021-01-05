require 'rails_helper'

RSpec.describe Datespot, type: :model do
  let!(:datespot) { create(:datespot) }

  context "バリデーション" do
    it "有効な状態であること" do
      expect(datespot).to be_valid
    end

    it "名称・店名がなければ無効な状態であること" do
      datespot = build(:datespot, name: nil)
      datespot.valid?
      expect(datespot.errors[:name]).to include("を入力または選択してください")
    end

    it "名称・店名が50文字以内であること" do
      datespot = build(:datespot, name: "あ" * 51)
      datespot.valid?
      expect(datespot.errors[:name]).to include("は50文字以内で入力してください")
    end

    it "都道府県がなければ無効な状態であること" do
      datespot = build(:datespot, prefecture_code: nil)
      datespot.valid?
      expect(datespot.errors[:prefecture_code]).to include("を入力または選択してください")
    end

    it "住所がなければ無効な状態であること" do
      datespot = build(:datespot, address: nil)
      datespot.valid?
      expect(datespot.errors[:address]).to include("を入力または選択してください")
    end

    it "予算がなければ無効な状態であること" do
      datespot = build(:datespot, range: nil)
      datespot.valid?
      expect(datespot.errors[:range]).to include("を入力または選択してください")
    end

    it "お誘い一言がなければ無効な状態であること" do
      datespot = build(:datespot, invitation: nil)
      datespot.valid?
      expect(datespot.errors[:invitation]).to include("を入力または選択してください")
    end

    it "お誘い一言が50文字以内であること" do
      datespot = build(:datespot, invitation: "あ" * 51)
      datespot.valid?
      expect(datespot.errors[:invitation]).to include("は50文字以内で入力してください")
    end

    it "デート詳細が255文字以内であること" do
      datespot = build(:datespot, plan: "あ" * 256)
      datespot.valid?
      expect(datespot.errors[:plan]).to include("は255文字以内で入力してください")
    end

    it "ユーザーIDがなければ無効な状態であること" do
      datespot = build(:datespot, user_id: nil)
      datespot.valid?
      expect(datespot.errors[:user_id]).to include("を入力または選択してください")
    end
  end
end
