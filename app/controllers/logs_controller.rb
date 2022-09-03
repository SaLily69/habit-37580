class LogsController < ApplicationController

  def new
  end

  def create
    Log.create(log_params)
  end

  private
  def log_params
    params.require(:log).permit(:study_day,:study_hour,:study_minute,:task,:feed_back,:time_remind).merge(goal_id: params[:goal_id])
  end

end
