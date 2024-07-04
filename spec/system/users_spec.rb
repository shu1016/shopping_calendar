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
      expect(page).to have_content("新規登録")
      # 新規登録ページへ移動する
      visit new_user_registration_path
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
      expect(page).to have_content("新規登録")
      # 新規登録ページへ移動する
      visit new_user_registration_path
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
  end
  context 'ログインができるとき' do 
    it '正しい情報を入力すればログインができてトップページに移動する' do
      # トップページに移動する
      visit root_path
      # ユーザー情報を入力する
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      # ログインボタンを押すとuser#indexへ遷移することを確認する
      find('input[name="commit"]').click
      sleep 3
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
  context 'ログインができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # ユーザー情報を入力する
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      # ログインボタンを押してもuser#indexへ遷移しないことを確認する
      find('input[name="commit"]').click
      expect(page).to have_current_path(root_path)
    end
  end
end