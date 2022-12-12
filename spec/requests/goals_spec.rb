require 'rails_helper'
describe GoalsController, type: :request do

  before do
    @goal = FactoryBot.create(:goal)
  end

  describe "GET #index" do
    #devise修正しないと通らない
    it '' do
    end
  end
end
