class GoalsController < ApplicationController
  #before_action :move_to_new
  before_action :set_goal, only:[:index, :edit]

  def index
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

  def edit
  end

  private
  def goal_params
    params.require(:goal).permit(:theme, :purpose, :target_total_time).merge(user_id: current_user.id)
  end

  def set_goal
    @goal = Goal.find(current_user.id)
  end

  #追加実装、目標を設定しなければtoppageに遷移できない
  #def move_to_new
    #unless Goal.exists?(goal_id: goal.id)
      #redirect_to new_goal_path
    #else
      #redirect_to root_path
    #end
  #end

end
