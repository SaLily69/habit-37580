require 'rails_helper'

RSpec.describe '学習記録の投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @goal = FactoryBot.create(:goal)
    @log = FactoryBot.create(:log)
  end

  context '学習記録が投稿できるとき' do
    it 'ログインしたユーザーは学習記録を投稿できる' do
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

    #学習を開始のボタンがあることを確認する
    expect(page).to have_content('学習を開始')
    #学習記録ページに遷移する
    visit goal_logs_path(@goal.id)
    #フォームに情報を入力する
    select '2022',from: 'log_study_day_1i'
    select 'December',from: 'log_study_day_2i'
    select '15', from: 'log_study_day_3i'
    fill_in 'log_study_hour', with: @log.study_hour
    fill_in 'log_study_minute', with: @log.study_minute
    fill_in 'log_task', with: @log.task
    fill_in 'log_feed_back', with: @log.feed_back
    fill_in 'log_time_remind', with: @log.time_remind
    #Logモデルのバリデーションに成功している
    expect(@log).to be_valid
    binding.pry
    #送信するとLogモデルのカウントが1上がることを確認する
    expect{
      find('input[name="commit"]').click
    }.to change {Log.count}.by(1)
    binding.pry

    #トップページに遷移することを確認する
    expect(current_path).to eq(goals_path)
    #トップページに学習記録があることを確認する
    expect(page).to have_content(@log.study_hour)
    #トップページに学習時間の総計があることを確認する
    #expect(page).to have_content(@study_hour_total)
    #トップページに学習の進捗率があることを確認する
    #expect(page).to have_content(@achievment_rate)
    end
  end
end
