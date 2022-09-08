class LogsController < ApplicationController

  def create
    @log = Log.new(log_params)
    if @log.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def log_params
    params.require(:log).permit(:study_day,:study_hour,:study_minute,:task,:feed_back,:time_remind).merge(goal_id: params[:goal_id])
  end

end
