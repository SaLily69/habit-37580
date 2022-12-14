require 'rails_helper'
describe GoalsController, type: :request do

  before do
    @goal = FactoryBot.create(:goal)
    @log = FactoryBot.create(:log)
  end

  describe "GET #index" do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
    get root_path
    expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスに設定済のゴールが存在する' do
    get root_path
    binding.pry
    expect(response.body).to include(@goal)
    end
    
    #it 'indexアクションにリクエストするとレスポンスに投稿済の学習記録が存在する' do
    
    #end
  end
end
