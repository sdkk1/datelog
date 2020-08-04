require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  describe "HomePage" do
    before do
      visit root_path
    end

    it "datelogの文字列が存在することを確認" do
      expect(page).to have_content 'datelog'
    end

    it "正しいタイトルが表示されることを確認" do
      expect(page).to have_title full_title
    end
  end

  describe "AboutPage" do
    before do
      visit about_path
    end

    it "デートログとは？の文字列が存在することを確認" do
      expect(page).to have_content 'デートログとは？'
    end

    it "正しいタイトルが表示されることを確認" do
      expect(page).to have_title full_title('デートログとは？')
    end
  end

  describe "TermsPage" do
    before do
      visit use_of_terms_path
    end

    it "利用規約の文字列が存在することを確認" do
      expect(page).to have_content '利用規約'
    end

    it "正しいタイトルが表示されることを確認" do
      expect(page).to have_title full_title('利用規約')
    end
  end
end
