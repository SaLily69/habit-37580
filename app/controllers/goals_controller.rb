class GoalsController < ApplicationController
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
      @logs = Log.where(goal_id: @goal.id).order("created_at DESC")
      @log = Log.where(goal_id: @goal.id).last
      calc_time
      calc_achievment
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
      calc_achievment
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

  def calc_achievment
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
      achievment_rate_i = b.to_i
      @achievment_rate = achievment_rate_i
    else
      achievment_rate = 0
      @achievment_rate = achievment_rate
    end
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
