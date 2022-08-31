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
    else

    end
  end

  def edit
  end

  def update
    goal = Goal.find(current_user.id)
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
      redirect_to root_path
    end
  end

  private
  def goal_params
    params.require(:goal).permit(:theme, :purpose, :target_total_time).merge(user_id: current_user.id)
  end

  def set_goal
    if Goal.exists?(user_id: current_user.id) && user_signed_in?
      @goal = Goal.find(params[:id])
    else
      redirect_to root_path
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
