class LogsController < ApplicationController

  def index
    @log = Log.new
  end

  def create
    @log = Log.new(log_params)
    if @log.save
      redirect_to root_path
    else
      render :index
    end
  end

  def show
    @logs = Log.where(goal_id: @goal.id).order("created_at DESC")
  end

  private

  def log_params
    params.require(:log).permit(:study_day,:study_hour,:study_minute,:task,:feed_back,:time_remind).merge(goal_id: params[:goal_id])
  end

end
