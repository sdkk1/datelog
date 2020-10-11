require 'rails_helper'

RSpec.describe BrowsingHistory, type: :model do
  let!(:browsing_history) { create(:browsing_history) }

  it "browsing_historyインスタンスが有効であること" do
    expect(browsing_history).to be_valid
  end

  it "user_idがnilの場合、無効であること" do
    browsing_history.user_id = nil
    expect(browsing_history).not_to be_valid
  end

  it "datespot_idがnilの場合、無効であること" do
    browsing_history.datespot_id = nil
    expect(browsing_history).not_to be_valid
  end
end
