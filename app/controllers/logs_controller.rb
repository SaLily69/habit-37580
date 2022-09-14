class LogsController < ApplicationController
  before_action :set_goal

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
    @log = Log.find(params[:id])
  end

  private

  def log_params
    params.require(:log).permit(:study_day,:study_hour,:study_minute,:task,:feed_back,:time_remind).merge(goal_id: params[:goal_id])
  end

  def set_goal
    @goal = Goal.find_by(user_id: current_user.id)
  end

end
