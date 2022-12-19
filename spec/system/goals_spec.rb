require 'rails_helper'

RSpec.describe '学習目標の一覧ページ', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @goal = FactoryBot.create(:goal)
    @logs = FactoryBot.create(:log)
    @log = FactoryBot.create(:log)
  end

  context '学習目標が設定できるとき' do
    it 'ログインしたユーザーは学習目標が設定できる' do
    #ログインする
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)
    #目標の設定ボタンがあることを確認する
    expect(page).to have_content('目標の設定')
    #目標設定ページに移動する
    visit new_goal_path
    #フォームに情報を入力する
    fill_in 'goal_theme', with: @goal.theme
    fill_in 'goal_target_total_time', with: @goal.target_total_time
    fill_in 'goal_purpose', with: @goal.purpose
    #送信するとGoalモデルのカウントが1上がることを確認する
    expect{
      find('input[name="commit"]').click
    }.to change {Goal.count}.by(1)
    #トップページに遷移することを確認する
    expect(current_path).to eq(root_path)
    #トップページに設定した目標があることを確認する
    expect(page).to have_content(@goal.theme)
    expect(page).to have_content(@goal.target_total_time)
    expect(page).to have_content(@goal.purpose)
    end
  end
end
