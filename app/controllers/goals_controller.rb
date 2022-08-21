class GoalsController < ApplicationController
  def index
    #@goal = Goal.find(current_user.id)
  end

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

  private
  def goal_params
    params.require(:goal).permit(:theme, :purpose, :target_total_time).merge(user_id: current_user.id)
  end

end
