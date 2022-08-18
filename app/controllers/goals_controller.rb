class GoalsController < ApplicationController
  def index
    #@goal = Goal.find(current_user.id)
  end

  def new
    @goal = Goal.new
  end

  def create
    Goal.create(goal_params)
  end

end
