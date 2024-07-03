require 'rails_helper'

RSpec.describe Favorite, type: :model do
  before do
    @favorite = FactoryBot.build(:favorite)
  end

  describe 'お気に入り登録' do
    context '登録できる'do
      it 'user_id,evvent_idが揃っていれば登録できる' do
        expect(@favorite).to be_valid
      end
    end
    context '登録できない' do
      it 'user_idがなければ登録できない' do
        @favorite.user = nil
        @favorite.valid?
        expect(@favorite.errors.full_messages).to include("User must exist")
      end
      it 'event_idがなければ登録できない' do
        @favorite.event = nil
        @favorite.valid?
        expect(@favorite.errors.full_messages).to include("Event must exist")
      end
    end
  end
end
