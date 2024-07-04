require 'rails_helper'
describe UsersController, type: :request do
  
  before do
    @user = FactoryBot.create(:user)
    @event = FactoryBot.create(:event, user: @user)
    sign_in @user
  end

  describe 'GET #index' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      get users_path
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスにカレンダーが存在する' do
      get users_path
      expect(response.body).to include ("calendar_day_titles")
    end
    it 'indexアクションにリクエストするとレスポンスにuserのイベントタイトルが存在する' do
      get users_path
      expect(response.body).to include (@event.title)
    end
    it 'indexアクションにリクエストするとレスポンスにネクストボタンが存在する' do
      get users_path
      expect(response.body).to include ('Next')
    end
    it 'indexアクションにリクエストするとレスポンスにバックボタンが存在する' do
      get users_path
      expect(response.body).to include ('Back')
    end
  end
  describe 'GET #show' do
    it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do
      get user_path(@user)
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスにニックネームが存在する' do
      get user_path(@user)
      expect(response.body).to include (@user.nickname)
    end
    it 'indexアクションにリクエストするとレスポンスにuserのイベントタイトルが存在する' do
      get user_path(@user)
      expect(response.body).to include (@event.title)
    end
    it 'indexアクションにリクエストするとレスポンスに編集が存在する' do
      get user_path(@user)
      expect(response.body).to include ('編集')
    end
    it 'indexアクションにリクエストするとレスポンスにお気に入りが存在する' do
      get user_path(@user)
      expect(response.body).to include ('お気に入り')
    end
  end
end
