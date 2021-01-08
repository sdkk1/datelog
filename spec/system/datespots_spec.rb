require 'rails_helper'

RSpec.describe "Datespots", type: :system do
  let!(:admin_user) { create(:user, :admin) }
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:datespot) { create(:datespot, user: user) }
  let!(:comment) { create(:comment, user: user, datespot: datespot) }

  describe "提案一覧ページ" do
    before do
      create_list(:datespot, 5)
    end

    context "ページレイアウト(共通)" do
      before do
        login_for_system(user)
        visit datespots_path
      end

      it "「デートを探す」の文字列が存在することを確認" do
        expect(page).to have_content 'デートを探す'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title('デートを探す')
      end

      it "みんなの提案の件数が表示されていることを確認" do
        expect(page).to have_content "みんなの提案: #{Datespot.all.count}件"
      end
    end

    context "ページレイアウト(管理者ユーザーの場合)" do
      before do
        login_for_system(admin_user)
        visit datespots_path
      end

      it "デートスポットの情報が表示されていることを確認(提案者のリンクあり)" do
        Datespot.take(5).each do |datespot|
          expect(page).to have_link datespot.name
          expect(page).to have_content datespot.address
          expect(page).to have_content datespot.range_i18n
          expect(page).to have_content datespot.tag_list
          expect(page).to have_link datespot.user.name
        end
      end
    end

    context "提案削除(管理者ユーザーの場合)", js: true do
      it "提案を削除後、削除成功のフラッシュが表示されること" do
        login_for_system(admin_user)
        visit datespots_path
        within first('.datespot-index__card') do
          page.accept_confirm("本当に削除しますか？") do
            find('#datespot-delete').click
          end
        end
        expect(page).to have_content '提案が削除されました'
      end
    end

    context "ページレイアウト(管理者ユーザー以外の場合)" do
      before do
        login_for_system(user)
      end

      it "デートスポットの情報が表示されていることを確認(提案者のリンクあり)" do
        Datespot.take(5).each do |datespot|
          expect(page).to have_link datespot.name
          expect(page).to have_content datespot.address
          expect(page).to have_content datespot.range_i18n
          expect(page).to have_content datespot.tag_list
          expect(page).to have_link datespot.user.name
        end
      end

      it "自分の提案のみ削除ボタンが表示されること" do
        Datespot.take(5).each do |datespot|
          expect(page).to have_link "削除" if datespot == user.datespots
        end
      end
    end

    context "提案削除(管理者ユーザー以外の場合)", js: true do
      it "自分の提案を削除後、削除成功のフラッシュが表示されること" do
        login_for_system(user)
        visit datespots_path
        if datespot == user.datespots
          within first('.datespots__card') do
            page.accept_confirm("本当に削除しますか？") do
              find('#datespot-delete').click
            end
          end
          expect(page).to have_content '提案が削除されました'
        end
      end
    end

    context "お気に入り登録/解除" do
      it "提案一覧ページから提案のお気に入り登録/解除ができること" do
        login_for_system(user)
        visit datespots_path
        expect(user.favorite?(datespot)).to be_falsey
        user.favorite(datespot)
        expect(user.favorite?(datespot)).to be_truthy
        user.unfavorite(datespot)
        expect(user.favorite?(datespot)).to be_falsey
      end
    end

    context "リスト登録/解除" do
      it "提案一覧ページから提案のリスト登録/解除ができること" do
        login_for_system(user)
        visit datespots_path
        expect(user.list?(datespot)).to be_falsey
        user.list(datespot)
        expect(user.list?(datespot)).to be_truthy
        user.unlist(List.first)
        expect(user.list?(datespot)).to be_falsey
      end
    end
  end

  describe "提案ページ" do
    before do
      login_for_system(user)
      visit new_datespot_path
    end

    context "ページレイアウト" do
      it "「提案する」の文字列が存在すること" do
        expect(page).to have_content '提案する'
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('提案する')
      end

      it "入力部分に適切なラベルが表示されること" do
        expect(page).to have_content '名称・店名'
        expect(page).to have_content '都道府県'
        expect(page).to have_content '住所'
        expect(page).to have_content '予算'
        expect(page).to have_content 'お誘い一言'
        expect(page).to have_content '写真'
        expect(page).to have_content 'キーワード'
        expect(page).to have_content '参考URL'
        expect(page).to have_content 'デート詳細'
      end
    end

    context "提案する処理" do
      it "有効な情報で提案を行うと提案が成功する" do
        fill_in "名称・店名", with: "ももたろう"
        select "東京都", from: '都道府県'
        fill_in "住所", with: "東京都渋谷区恵比寿西"
        select '~2,000', from: '予算'
        fill_in "datespot_tag", with: "オシャレ,焼き鳥"
        fill_in "お誘い一言", with: "一緒にお食事しませんか？"
        fill_in "デート詳細", with: "オシャレなお店でお食事をしながら、会話を楽しむ。"
        click_button "提案する"
      end

      it "無効な情報で提案を行うと提案失敗のフラッシュが表示されること" do
        fill_in "名称・店名", with: ""
        select "東京都", from: '都道府県'
        fill_in "住所", with: "東京都渋谷区恵比寿西"
        select '~2,000', from: '予算'
        fill_in "datespot_tag", with: "オシャレ,焼き鳥"
        fill_in "お誘い一言", with: "一緒にお食事しませんか？"
        fill_in "デート詳細", with: "オシャレなお店でお食事をしながら、会話を楽しむ。"
        click_button "提案する"
        expect(page).to have_content "名称・店名を入力または選択してください"
      end
    end
  end

  describe "提案詳細ページ" do
    before do
      visit datespot_path(datespot)
    end

    context "ページレイアウト（共通）" do
      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title("#{datespot.name}")
      end
    end

    context "ページレイアウト(管理者ユーザーの場合)" do
      before do
        login_for_system(admin_user)
        visit datespot_path(datespot)
      end

      it "提案情報が表示されること(提案者のリンクあり)" do
        expect(page).to have_content datespot.name
        expect(page).to have_link datespot.user.name
        expect(page).to have_content datespot.address
        expect(page).to have_content datespot.range_i18n
        expect(page).to have_content datespot.tag_list
        expect(page).to have_content datespot.invitation
        expect(page).to have_content datespot.plan
      end
    end

    context "提案削除(管理者ユーザーの場合)", js: true do
      it "提案を削除後、削除成功のフラッシュが表示されること" do
        login_for_system(admin_user)
        visit datespot_path(datespot)
        page.accept_confirm("本当に削除しますか？") do
          find('#datespot-delete').click
        end
        expect(page).to have_content '提案が削除されました'
      end
    end

    context "ページレイアウト(管理者ユーザー以外の場合)" do
      before do
        login_for_system(user)
        visit datespot_path(datespot)
      end

      it "提案情報が表示されること(提案者のリンクあり)" do
        expect(page).to have_content datespot.name
        expect(page).to have_link datespot.user.name
        expect(page).to have_content datespot.address
        expect(page).to have_content datespot.range_i18n
        expect(page).to have_content datespot.tag_list
        expect(page).to have_content datespot.invitation
        expect(page).to have_content datespot.plan
      end

      it "自分の提案のみ削除ボタンが表示されること" do
        expect(page).to have_link "削除" if datespot == user.datespots
      end
    end

    context "提案削除(管理者ユーザー以外の場合)", js: true do
      it "自分の提案を削除後、削除成功のフラッシュが表示されること" do
        login_for_system(user)
        visit datespot_path(datespot)
        if datespot == user.datespots
          page.accept_confirm("本当に削除しますか？") do
            click_on "削除"
          end
          expect(page).to have_content '提案が削除されました'
        end
      end
    end

    context "ページレイアウト(ログインしていないユーザーの場合)" do
      it "提案情報が表示されること(提案者のリンクなし)" do
        expect(page).to have_content datespot.name
        expect(page).to have_content datespot.user.name
        expect(page).to have_content datespot.address
        expect(page).to have_content datespot.range_i18n
        expect(page).to have_content datespot.tag_list
        expect(page).to have_content datespot.invitation
        expect(page).to have_content datespot.plan
      end

      it "削除ボタンが表示されないこと" do
        expect(page).to have_no_link "削除"
      end
    end

    context "お気に入り登録/解除" do
      it "提案詳細ページから提案のお気に入り登録/解除ができること" do
        login_for_system(user)
        visit datespot_path(datespot)
        link = find('.like')
        expect(link[:href]).to include "/favorites/#{datespot.id}/create"
        link.click
        link = find('.unlike')
        expect(link[:href]).to include "/favorites/#{datespot.id}/destroy"
        link.click
        link = find('.like')
        expect(link[:href]).to include "/favorites/#{datespot.id}/create"
      end
    end

    context "リスト登録/解除" do
      it "提案詳細ページからリスト登録/解除ができること" do
        login_for_system(user)
        visit datespot_path(datespot)
        if datespot == user.datespots
          link = find('.list')
          expect(link[:href]).to include "/lists/#{datespot.id}/create"
          link.click
          link = find('.unlist')
          expect(link[:href]).to include "/lists/#{List.first.id}/destroy"
          link.click
          link = find('.list')
          expect(link[:href]).to include "/lists/#{datespot.id}/create"
        end
      end
    end

    context "コメント登録/削除" do
      it "別ユーザーによる提案のコメントには削除リンクが無いこと" do
        login_for_system(other_user)
        visit datespot_path(datespot)
        within find("#comment-#{comment.id}") do
          expect(page).to have_link comment.user.name
          expect(page).to have_content comment.content
          expect(page).not_to have_link '削除', href: "/datespots/#{datespot.id}/comments/#{comment.id}"
        end
      end
    end
  end

  describe "提案編集ページ" do
    before do
      login_for_system(user)
      visit datespot_path(datespot)
      find('#datespot-edit').click
    end

    context "ページレイアウト" do
      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('編集する')
      end

      it "入力部分に適切なラベルが表示されること" do
        expect(page).to have_content '名称・店名'
        expect(page).to have_content '都道府県'
        expect(page).to have_content '住所'
        expect(page).to have_content '予算'
        expect(page).to have_content 'お誘い一言'
        expect(page).to have_content '写真'
        expect(page).to have_content 'キーワード'
        expect(page).to have_content '参考URL'
        expect(page).to have_content 'デート詳細'
      end
    end

    context "提案の更新処理" do
      it "有効な更新" do
        fill_in "名称・店名", with: "ももたろう"
        select "東京都", from: '都道府県'
        fill_in "住所", with: "東京都渋谷区恵比寿西"
        select '~2,000', from: '予算'
        fill_in "datespot_tag", with: "オシャレ,焼き鳥"
        fill_in "お誘い一言", with: "一緒にお食事しませんか？"
        fill_in "デート詳細", with: "オシャレなお店でお食事をしながら、会話を楽しむ。"
        click_button "更新する"
        expect(datespot.reload.name).to eq "ももたろう"
        expect(datespot.reload.prefecture.name).to eq "東京都"
        expect(datespot.reload.address).to eq "東京都渋谷区恵比寿西"
        expect(datespot.reload.range_i18n).to eq "~2,000"
        expect(datespot.reload.tag_list).to eq ["オシャレ", "焼き鳥"]
        expect(datespot.reload.invitation).to eq "一緒にお食事しませんか？"
        expect(datespot.reload.plan).to eq "オシャレなお店でお食事をしながら、会話を楽しむ。"
      end

      it "無効な更新" do
        fill_in "名称・店名", with: ""
        click_button "更新する"
        expect(page).to have_content '名称・店名を入力または選択してください'
        expect(datespot.reload.name).not_to eq ""
      end
    end

    context "提案削除", js: true do
      it "提案を削除後、削除成功のフラッシュが表示されること" do
        page.accept_confirm("本当にこの提案を削除してもよろしいですか？") do
          click_on "提案を削除する"
        end
        expect(page).to have_content '提案が削除されました'
      end
    end
  end
end
