require 'rails_helper'
describe GoalsController, type: :request do

  before do
    @user = FactoryBot.create(:user)
    @goal = FactoryBot.create(:goal)
    @log = FactoryBot.create(:log)
    sign_in @user
  end

  describe "GET #index" do

    context 'ログインしている場合' do

      it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
        get root_path
        expect(response.status).to eq 200
      end

      it '学習テーマが正しく表示されている' do
      binding.pry
      expect(response.body).to include("学習テーマ")
      end
    end

  end
    #context 'ログインしていない場合' do
      #it 'ログインページにリダイレクトされる' do
        #get root_path
        #expect(response.status).to eq 302
      #end
    #end
end
