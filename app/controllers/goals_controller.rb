class GoalsController < ApplicationController
  require 'csv' 
  before_action :authenticate_user!
  #before_action :move_to_new
  before_action :set_goal, only:[:edit, :destroy]

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    if @goal.save
      redirect_to root_path
    else
      render :new
    end
  end

  def index
    if Goal.exists?(user_id: current_user.id) && user_signed_in?
      @goal = Goal.find_by(user_id: current_user.id)
      @logs = Log.where(goal_id: @goal.id).order("study_day DESC")
      @log = Log.where(goal_id: @goal.id).last
      calc_time
      @achievment_rate = calc_achievment(@goal)
      gon.graph_data = graph(@achievment_rate)
    end
    if Log.exists?
      @logs = Log.where(goal_id: @goal.id).order("study_day DESC")
      respond_to do |format|
        format.html
        format.csv do |csv|
          send_logs_csv(@logs)
        end
      end
    end
  end

  def edit
  end

  def update
    goal = Goal.find_by(user_id: current_user.id)
    if goal.update(goal_params)
      redirect_to root_path
    else
      @goal = goal
      render :edit
    end
  end

  def destroy
    if @goal.destroy
      redirect_to root_path
    else
      redirect_to edit_goal_path
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:theme, :purpose, :target_total_time).merge(user_id: current_user.id)
  end

  def set_goal
    if Goal.exists?(user_id: current_user.id) && user_signed_in?
      @goal = Goal.find_by(user_id: current_user.id)
      @logs = Log.where(goal_id: @goal.id).order("created_at DESC")
      @log = Log.where(goal_id: @goal.id).last
      calc_time
      @achievment_rate = calc_achievment(@goal)
    else
      redirect_to root_path
    end
  end

  def calc_time
    study_hour = Log.where(goal_id: @goal.id).pluck(:study_hour)
    study_minute = Log.where(goal_id: @goal.id).pluck(:study_minute)
    study_hour_total = study_hour.sum
    study_minute_total = study_minute.sum
    if study_minute_total >= 60
      carry_up_hour = study_minute_total / 60
      study_hour_total += carry_up_hour
      @study_hour_total = study_hour_total
      @study_minute_total = study_minute_total % 60
    else
      @study_hour_total = study_hour_total
      @study_minute_total = study_minute_total
    end
  end

  def calc_achievment(rate)
    if Log.exists?(goal_id: @goal.id)
      study_hour = Log.where(goal_id: @goal.id).pluck(:study_hour)
      study_minute = Log.where(goal_id: @goal.id).pluck(:study_minute)
      study_hour_sum = study_hour.sum
      study_minute = Log.where(goal_id: @goal.id).pluck(:study_minute)
      study_minute_total = study_minute.sum
      study_hour_total = study_hour_sum * 60 + study_minute_total
    
      goal_time = @goal.target_total_time
      goal_time_sum = goal_time * 60 

      achievment_rate = sprintf("%.2f",study_hour_total / goal_time_sum.to_f)
      a, b = achievment_rate.to_s.split(".")
      achievment_rate= b.to_i 
    else
      achievment_rate = 0
    end
  end

  def graph(achievment_rate)
    achievment_rate = @achievment_rate
    time_required = 100 - achievment_rate
    graph_data = [achievment_rate , time_required]
  end

  def send_logs_csv(logs)
    csv_data = CSV.generate do |csv|
      column_names = %w(学習日 学習時間（時間） 学習時間（分） メモ 自己評価)
      csv << column_names

      logs.each do |log|
        column_values = [
          log.study_day,
          log.study_hour,
          log.study_minute,
          log.task,
          log.feed_back
        ]
        csv << column_values
      end
    end
    send_data(csv_data, filename: "学習記録一覧.csv")
  end


  #追加実装、目標を設定しなければtoppageに遷移できない
  #def move_to_new
    #unless Goal.exists? && user_signed_in?
      #redirect_to new_goal_path
    #else
      #redirect_to root_path
    #end
  #end

end
