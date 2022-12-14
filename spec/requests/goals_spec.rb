require 'rails_helper'
describe GoalsController, type: :request do

  before do
    #@goal = FactoryBot.create(:goal)
    @log = FactoryBot.build(:log)
  end

  describe "GET #index" do
    #devise：パスワード入力フォームはなく、ログイン自体もできるがテスト上は入力がないとエラーが出る
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
    get root_path
    expect(response.status).to eq 401
    end
    #it 'indexアクションにリクエストするとレスポンスに設定済のゴールが存在する' do
    #get root_path
    #expect(response.body).to include(@goal)
    #end
  end
end
