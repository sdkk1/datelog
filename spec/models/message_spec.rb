require 'rails_helper'

RSpec.describe Message, type: :model do
  let!(:message) { create(:message) }

  it "messageインスタンスが有効であること" do
    expect(message).to be_valid
  end

  it "user_idがnilの場合、無効であること" do
    message.user_id = nil
    expect(message).not_to be_valid
  end

  it "room_idがnilの場合、無効であること" do
    message.room_id = nil
    expect(message).not_to be_valid
  end

  it "contentがnilの場合、無効であること" do
    message.content = nil
    expect(message).not_to be_valid
  end

  it "コメントが255文字以内であること" do
    message = build(:message, content: "あ" * 256)
    message.valid?
    expect(message.errors[:content]).to include("は255文字以内で入力してください")
  end
end
