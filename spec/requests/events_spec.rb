require 'rails_helper'
describe EventsController, type: :request do

  before do
    @user = FactoryBot.create(:user)
    sign_in @user
    @event = FactoryBot.create(:event)
  end

  describe 'GET #index' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      get events_path
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのイベントのテキストが存在する' do
      get events_path
      expect(response.body).to include(@event.title)
    end
    it 'indexアクションにリクエストするとレスポンスに都道府県検索フォームが存在する' do
      get events_path
      expect(response.body).to include("都道府県を選択")
    end
    it 'indexアクションにリクエストするとレスポンスに市区町村検索フォームが存在する' do
      get events_path
      expect(response.body).to include("市区町村を入力")
    end
    it 'indexアクションにリクエストするとレスポンスにお気に入りボタンが存在する' do
      get events_path
      expect(response.body).to include("☆")
    end
  end
  describe 'GET #new' do
    it 'newアクションにリクエストすると正常にレスポンスが返ってくる' do 
      get new_event_path
      expect(response.status).to eq 200
    end
    it 'newアクションにリクエストするとレスポンスにtitleフォームが含まれている' do 
      get new_event_path
      expect(response.body).to include('店名')
    end
    it 'newアクションにリクエストするとレスポンスにcontentフォームが含まれている' do 
      get new_event_path
      expect(response.body).to include('内容')
    end
    it 'newアクションにリクエストするとレスポンスに期間フォームが含まれている' do 
      get new_event_path
      expect(response.body).to include('開始日','終了日')
    end
    it 'newアクションにリクエストするとレスポンスにmemoボタンが含まれている' do 
      get new_event_path
      expect(response.body).to include('メモ投稿')
    end
  end
  describe 'GET #edit' do
    it 'editアクションにリクエストすると正常にレスポンスが返ってくる' do 
      @user = @event.user
      sign_in @user
      get edit_event_path(@event)
      expect(response.status).to eq 200
    end
    it 'editアクションにリクエストするとレスポンスにtitleフォームが含まれている' do 
      @user = @event.user
      sign_in @user
      get edit_event_path(@event)
      expect(response.body).to include('店名')
    end
    it 'editアクションにリクエストするとレスポンスにcontentフォームが含まれている' do 
      @user = @event.user
      sign_in @user
      get edit_event_path(@event)
      expect(response.body).to include('内容')
    end
    it 'editアクションにリクエストするとレスポンスに期間フォームが含まれている' do 
      @user = @event.user
      sign_in @user
      get edit_event_path(@event)
      expect(response.body).to include('開始日','終了日')
    end
    it 'editアクションにリクエストするとレスポンスに更新ボタンが含まれている' do 
      @user = @event.user
      sign_in @user
      get edit_event_path(@event)
      expect(response.body).to include('更新')
    end
  end
end

