require 'rails_helper'

RSpec.describe "Events", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @event = FactoryBot.build(:event)
  end

  context 'event投稿が出来るとき' do
    it 'ログインしたuserは投稿できる' do
      # ログインする
      sign_in(@user)
      # 新規投稿ページのボタンがある
      expect(page).to have_content('MEMO')
      find('#memo-menu').click
      expect(page).to have_content('新規メモ')
      expect(page).to have_content('メモ一覧')
      # 投稿ページに遷移する
      find('.new_memo_btn').click
      sleep 1
      expect(page).to have_current_path(new_event_path)
      # 投稿フォームに入力する
      fill_in 'event[title]', with: @event.title
      fill_in 'event[content]', with: @event.content
      select Date.today.year, from: 'event_start_time_1i'
      select Date.today.month, from: 'event_start_time_2i'
      select Date.today.day, from: 'event_start_time_3i'
      select Date.today.year, from: 'event_end_time_1i'
      select Date.today.month, from: 'event_end_time_2i'
      select Date.today.day + 1, from: 'event_end_time_3i'
      # 送信するとeventモデルのカウントが1上がる
      expect{
        find('input[name="commit"]').click
        sleep 1
      }.to change { Event.count }.by(1)
      # user#indexに遷移する
      expect(page).to have_current_path(users_path)
      # カレンダーに先ほどの投稿タイトルが存在する
      expect(page).to have_content(@event.title)
    end
  end
end
RSpec.describe "Events", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @event = FactoryBot.create(:event, user: @user)
  end
  context 'event投稿が出来ないとき' do
    it '記述漏れがあると投稿できない' do
      # ログインする
      sign_in(@user)
      # マイページのボタンがある
      find('.user_name').click
      sleep 1
      expect(page).to have_current_path(user_path(@user))
      # 投稿したeventが存在している
      expect(page).to have_content(@event.title)
      # event編集ボタンが存在している
      expect(page).to have_selector('.event_edit_link')
      # 編集ボタンをクリックすると編集ページへ遷移する
      find(".event_edit_link").click
      sleep 1
      expect(page).to have_current_path(edit_event_path(@event))
      # 投稿内容がフォームに記述されている
      expect(page).to have_field('event_title', with: @event.title)
      expect(page).to have_field('event_content', with: @event.content)
      # 本日以降の日付けを入力すると編集できる
      select Date.today.year, from: 'event_start_time_1i'
      select Date.today.month, from: 'event_start_time_2i'
      select Date.today.day, from: 'event_start_time_3i'
      select Date.today.year, from: 'event_end_time_1i'
      select Date.today.month, from: 'event_end_time_2i'
      select Date.today.day + 1, from: 'event_end_time_3i'
      #更新ボタンを押すとuser詳細ページに遷移する
      expect{
        find('input[name="commit"]').click
        sleep 1
      }.to change { Event.count }.by(0)
      #user詳細ページへ遷移する
      expect(page).to have_current_path(user_path(@user)) 
    end
  end
end
RSpec.describe "Events", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @event = FactoryBot.create(:event, user: @user)
    @event_delete = FactoryBot.create(:event, user: @user)
  end
  context 'event削除' do
    it 'event削除できる' do
      # ログインする
      sign_in(@user)
      # マイページのボタンがある
      find('.user_name').click
      sleep 1
      expect(page).to have_current_path(user_path(@user))
      # 投稿したeventが存在している
      expect(page).to have_content(@event_delete.title)
      # event編集ボタンが存在している
      expect(page).to have_selector('.event_delete_link')
      # 編集ボタンをクリックすると編集ページへ遷移する
      all(".event_delete_link")[1].click
      sleep 1
      expect(page).to have_current_path(user_path(@user))
      # 投稿内容がフォームに記述されている
      expect(page).to have_no_content(@event_delete.title)
    end
  end
end
