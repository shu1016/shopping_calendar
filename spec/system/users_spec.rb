require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      find('.new_user_btn_post').click
      sleep 1
      expect(page).to have_current_path(new_user_registration_path)
      # ユーザー情報を入力する
      fill_in 'user[nickname]', with: @user.nickname
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      fill_in 'user[password_confirmation]', with: @user.password_confirmation
      select '東京都', from: 'user[region_id]'
      fill_in 'user[city]', with: @user.city
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
        sleep 1
      }.to change { User.count }.by(1)
      # user#indexへ遷移することを確認する
      expect(page).to have_current_path(users_path)
      # ログアウトボタンが表示されていることを確認する
      expect(page).to have_content('ログアウト')
      expect(page).to have_content(@user.nickname)
      expect(page).to have_content('MEMO')
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('ログイン')
      # MEMOをクリックすると新規メモとメモ一覧が表示される
      find('#memo-menu').click
      expect(page).to have_content('新規メモ')
      expect(page).to have_content('メモ一覧')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      find('.new_user_btn_post').click
      sleep 1
      expect(page).to have_current_path(new_user_registration_path)
      # ユーザー情報を入力する
      fill_in 'user[nickname]', with: ''
      fill_in 'user[email]', with: ''
      fill_in 'user[password]', with: ''
      fill_in 'user[password_confirmation]', with: ''
      select '---', from: 'user[region_id]'
      fill_in 'user[city]', with: ''
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
        sleep 1
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(page).to have_current_path(new_user_registration_path)
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @event = FactoryBot.create(:event, user: @user)
  end
  context 'ログインができるとき' do 
    it '正しい情報を入力すればログインができてトップページに移動する' do
      #ログインする
      sign_in(@user)
      # ログアウトボタンが表示されていることを確認する
      expect(page).to have_content('ログアウト')
      expect(page).to have_content(@user.nickname)
      expect(page).to have_content('MEMO')
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('ログイン')
      # MEMOをクリックすると新規メモとメモ一覧が表示される
      find('#memo-menu').click
      expect(page).to have_content('新規メモ')
      expect(page).to have_content('メモ一覧')
    end
  end
  context 'ログインができないとき' do
    it '誤った情報ではログインできずにログインページへ戻ってくる' do
      visit root_path
      # ログインと新規登録のボタンが存在する
      expect(page).to have_content('ログイン')
      expect(page).to have_content('新規登録')
      # ログインページへ遷移する
      find('.login_btn_post').click
      sleep 1
      expect(page).to have_current_path(new_user_session_path)
      # ユーザー情報を入力する
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      # ログインボタンを押してもuser#indexへ遷移しないことを確認する
      find('input[name="commit"]').click
      expect(page).to have_current_path(new_user_session_path)
    end
  end
  context '詳細ページに遷移できる' do
    it 'ログインしていたら詳細ページに遷移し編集ページにも遷移できる' do
      # ログイン
      sign_in(@user)
      # user.nicknameをクリックしたら詳細ページに遷移
      find('.user_name').click
      sleep 1
      expect(page).to have_current_path(user_path(@user))
      # 基本情報、userの投稿一覧、お気に入り一覧が表示されている
      expect(page).to have_content('基本情報')
      expect(page).to have_content(@user.nickname)
      expect(page).to have_content('投稿一覧')
      expect(page).to have_content('お気に入り一覧')
      # 編集ボタンがある
      expect(page).to have_selector('.user_edit_link')
      expect(page).to have_selector('.event_edit_link')
      expect(page).to have_selector('.event_delete_link')
      # user情報編集ページに遷移できる
      find('.user_edit_link').click
      sleep 1
      expect(page).to have_current_path(edit_user_registration_path)
      # 編集ページには新規登録時のデータがある。
      sleep 1
      expect(page).to have_field('user_nickname', with: @user.nickname)
      expect(page).to have_field('user_email', with: @user.email)
      expect(page).to have_content(@user.region.name)
      expect(page).to have_field('user_city', with: @user.city)
      # user情報を更新できる
      fill_in 'user[current_password]', with: @user.password
      sleep 2
      @user.password = "2a"+Faker::Internet.password(min_length: 6)
      @user.password_confirmation = @user.password
      fill_in 'user[password]', with: @user.password
      fill_in 'user[password_confirmation]', with: @user.password_confirmation
      find('input[name="commit"]').click
      # 更新後ユーザー詳細へ遷移する
      sleep 1
      expect(page).to have_current_path(user_path(@user))
    end
  end
end