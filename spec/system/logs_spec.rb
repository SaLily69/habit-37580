require 'rails_helper'

RSpec.describe '学習記録の投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @goal = FactoryBot.create(:goal ,user: @user)
    @log  = FactoryBot.create(:log)
    @logs = create_list(:log, 3, goal: @goal)
  end

  context '学習記録が投稿できるとき' do
    it 'ログインしたユーザーは学習記録を投稿できる' do
    #既に登録データがある状態でログインする
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    find('input[name="commit"]').click
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
    fill_in 'log_study_hour', with: @log.study_hour
    fill_in 'log_study_minute', with: @log.study_minute
    fill_in 'log_task', with: @log.task
    fill_in 'log_feed_back', with: @log.feed_back
    fill_in 'log_time_remind', with: @log.time_remind
    #送信するとLogモデルのカウントが1上がることを確認する
    expect{
      find('input[name="commit"]').click
    }.to change {Log.count}.by(1)

    #トップページに遷移することを確認する
    expect(current_path).to eq(goals_path)

    #トップページに学習記録があることを確認する
    expect(page).to have_content('メモ')
    #トップページに次回の学習予定があることを確認する
    expect(page).to have_content('次回の学習予定')
    #トップページに学習合計時間（時間数）があることを確認する
    expect(page).to have_content @achievment_rate
    #トップページに学習合計時間（分数）があることを確認する
    expect(page).to have_content @total_hour
    #トップページに学習の進捗率があることを確認する
    expect(page).to have_content @total_minute
    #トップページに学習進捗率を示すグラフがあることを確認する
    #javascriptをテストするには別途gem(capybara-webkit)インストール必要

    #「学習記録を出力する」の表示があることを確認する
    expect(page).to have_content('学習記録を出力する')
    #「学習記録を出力する」をクリックする
    find('.out_csv', :text => '学習記録を出力する').click
    end
  end
end
