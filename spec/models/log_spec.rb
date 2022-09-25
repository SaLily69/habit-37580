require 'rails_helper'

RSpec.describe Log, type: :model do
  before do
    @log = FactoryBot.build(:log)
  end

  describe '学習記録の保存' do
    context '学習記録の保存ができる場合' do
      it '学習日、学習時間（時間）、学習時間（分）、学習メモ、自己評価、次回学習予定が入力されていると保存できる' do
        expect(@log).to be_valid
      end
      it '学習メモの入力がなくても、学習日・学習時間（時間）・学習時間（分）・自己評価・次回学習予定の入力で保存できる' do
        @log.task = ''
        expect(@log).to be_valid
      end
    end
    context '学習記録の保存ができない場合' do
      it '学習日が空では保存できない' do
        @log.study_day = ''
        @log.valid?
        expect(@log.errors.full_messages).to include "Study day can't be blank"
      end
      it '学習時間(時間)が空では保存できない' do
        @log.study_hour = ''
        @log.valid?
        expect(@log.errors.full_messages).to include "Study hour can't be blank"
      end
      it '学習時間(分)が空では保存できない' do
        @log.study_minute = ''
        @log.valid?
        expect(@log.errors.full_messages).to include "Study minute can't be blank"
      end
      it '自己評価が空では保存できない' do
        @log.feed_back = ''
        @log.valid?
        expect(@log.errors.full_messages).to include "Feed back can't be blank"
      end
      it '次回学習予定が空では保存できない' do
        @log.time_remind = ''
        @log.valid?
        expect(@log.errors.full_messages).to include "Time remind can't be blank"
      end     
      it 'ゴールが紐付いていなければ保存できない' do
        @log.goal = nil
        @log.valid?
        expect(@log.errors.full_messages).to include "Goal must exist"
      end
      it '学習時間(時間)は24以上の数値は保存できない' do
        @log.study_hour = '24'
        @log.valid?
        expect(@log.errors.full_messages).to include "Study hour must be less than or equal to 23"
      end
      it '学習時間(分)は60以上の数値は保存できない' do
        @log.study_minute = '60'
        @log.valid?
        expect(@log.errors.full_messages).to include "Study minute must be less than or equal to 59"
      end
      it '自己評価に5以上の数値が入力されると保存できない' do
        @log.feed_back = '10'
        @log.valid?
        expect(@log.errors.full_messages).to include "Feed back must be less than or equal to 5"
      end
      it '自己評価に1以下の数値が入力されると保存できない' do
        @log.feed_back = '0'
        @log.valid?
        expect(@log.errors.full_messages).to include "Feed back must be greater than or equal to 1"
      end
      it '学習時間(時間)が0の場合は学習時間(分)が1以上60以下でないと保存できない' do
        @log.study_hour = '0'
        @log.study_minute = '0'
        @log.valid?
        binding.pry
        expect(@log.errors.full_messages).to include "Study minute must be greater than or equal to 1"
      end
      #it '学習予定に過去の日時は入力できない' do
      #end
    end
  end
end
