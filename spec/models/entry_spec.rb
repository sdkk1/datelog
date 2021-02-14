require 'rails_helper'

RSpec.describe Entry, type: :model do
  let!(:entry) { create(:entry) }

  it "entryインスタンスが有効であること" do
    expect(entry).to be_valid
  end

  it "user_idがnilの場合、無効であること" do
    entry.user_id = nil
    expect(entry).not_to be_valid
  end

  it "room_idがnilの場合、無効であること" do
    entry.room_id = nil
    expect(entry).not_to be_valid
  end
end
