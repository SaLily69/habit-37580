require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    #it 'nicknameとemailが存在すれば登録できる' do
      #expect(@user).to be_valid
      #devise修正必要
    #end
    it 'nicknameが空では登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Nickname can't be blank"
    end
    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end
    it 'nicknameが16文字以上では登録できない' do
      @user.nickname = 'abcdefghijklmnop'
      @user.valid?
      expect(@user.errors.full_messages).to include "Nickname is too long (maximum is 15 characters)"
    end
    #it '重複したnicknameが存在する場合は登録できない' do
      #devise修正必要
      #@user.save
      #another_user = FactoryBot.build(:user)
      #another_user.nickname = @user.nickname
      #another_user.valid?
      #expect(another_user.errors.full_messages).to include ""
    #end
    it 'emailは@を含まないと登録できない' do
      @user.email = 'testmail'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end
  end
end
