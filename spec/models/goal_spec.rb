require 'rails_helper'

RSpec.describe Goal, type: :model do
  before do
    @goal = FactoryBot.build(:goal)
  end

  describe '学習目標の保存' do
    context '学習目標の保存ができる場合' do
      it '学習テーマ・目標・学習目標時間を入力すると保存できる' do
        expect(@goal).to be_valid
      end
    end
    context '学習目標の保存ができない場合' do
      it '学習テーマが空では保存できない' do
        @goal.theme = ''
        @goal.valid?
        expect(@goal.errors.full_messages).to include "Theme can't be blank"
      end
      it '学習目標が空では保存できない' do
        @goal.purpose = ''
        @goal.valid?
        expect(@goal.errors.full_messages).to include "Purpose can't be blank"
      end
      it '学習目標時間が空では保存できない' do
        @goal.target_total_time = ''
        @goal.valid?
        expect(@goal.errors.full_messages).to include "Target total time can't be blank"
      end
      it 'ユーザーが紐付いていなければ保存できない' do
        @goal.user = nil
        @goal.valid?
        expect(@goal.errors.full_messages).to include "User must exist"
      end
      #it '学習目標時間が◯時間でなければ保存できない' do
      #end
    end
  end
end
