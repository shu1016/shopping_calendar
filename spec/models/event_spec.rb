require 'rails_helper'

RSpec.describe Event, type: :model do
  before do
    @event = FactoryBot.build(:event)
  end

  describe 'イベント投稿' do
    context 'イベント投稿できるとき' do
      it '.tiitle.content.start_time.end_timeとuser_idが存在すれば登録できる' do
        expect(@event).to be_valid
      end
    end
    context 'イベント投稿できないとき' do
      it 'titleが空では投稿できない' do
        @event.title = ''
        @event.valid?
        expect(@event.errors.full_messages).to include("Title can't be blank")
      end
      it 'contentが空では投稿できない' do
        @event.content = ''
        @event.valid?
        expect(@event.errors.full_messages).to include("Content can't be blank" )
      end
      it 'start_timeが過去では投稿できない' do
        @event.start_time = Faker::Time.between(from: DateTime.now - 100, to: DateTime.now)
        @event.valid?
        expect(@event.errors.full_messages).to include("Start time 開始日は本日以降の日を入力してください")
      end
      it 'end_timeがstart_timeより過去では投稿できない' do
        @event.end_time = Faker::Time.between(from: DateTime.now - 10, to: DateTime.now)
        @event.valid?
        expect(@event.errors.full_messages).to include("End time 開始日より遅い日を設定してください")
      end
      it 'user_idが空では登録できない' do
        @event.user = nil
        @event.valid?
        expect(@event.errors.full_messages).to include("User must exist")
      end
    end
  end
end
