class LogsController < ApplicationController
  before_action :set_goal
  before_action :set_log, only: [:show, :destroy]

  def index
    @log = Log.new
  end

  def create
    @log = Log.new(log_params)
    if @log.save
      redirect_to goals_path
    else
      render :index
    end
  end

  def show
  end

  def destroy
    if @log.destroy
      redirect_to root_path
    else
      redirect_to goal_log_path
    end
  end

  private

  def log_params
    params.require(:log).permit(:study_day,:study_hour,:study_minute,:task,:feed_back,:time_remind).merge(goal_id: params[:goal_id])
  end

  def set_goal
    @goal = Goal.find_by(user_id: current_user.id)
  end

  def set_log
    @log = Log.find(params[:id])
  end

end
